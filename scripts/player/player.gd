extends CharacterBody2D

@export var speed := 200.0
@onready var anim = $AnimatedSprite2D

# ===== COMPONENTS =====
@onready var movement: Node = $movement
@onready var combat: Node = $combat
@onready var stats: Node = $stats

# ===== PLAYER STATE =====
var last_direction := "down"
var is_attacking := false
var current_anim := ""
var is_dead := false
var spawn_position: Vector2

# ======
# READY 
# ======
func _ready():
	movement.setup(self)
	combat.setup(self)

	spawn_position = global_position  

	stats.connect("died", _on_player_died)  
	

# =====================================================
# MAIN LOOP
# =====================================================
func _physics_process(delta):
	
	if is_dead:
		velocity = Vector2.ZERO
		move_and_slide()
		return
		
	if is_attacking:
		velocity = Vector2.ZERO
		move_and_slide()
		return

	# ===== ATTACK SYSTEM =====
	combat.try_attack()
	if is_attacking:
		move_and_slide()
		return

	# ===== MOVEMENT SYSTEM =====
	var input_vector = movement.get_input_vector()
	movement.handle_movement(input_vector)

	move_and_slide()

# =====================
# ANIMATION SAFE PLAYER
# =====================
func play_anim_safe(anim_name: String):
	if current_anim != anim_name:
		current_anim = anim_name
		anim.play(anim_name)

func update_last_direction(dir: Vector2):
	if abs(dir.x) > abs(dir.y):
		last_direction = "right" if dir.x > 0 else "left"
	else:
		last_direction = "down" if dir.y > 0 else "up"

#=====================
#Death & respawn 
#=====================
func _on_player_died():
	if is_dead:
		return

	is_dead = true
	print("Player chết")

	is_attacking = false
	velocity = Vector2.ZERO

	play_anim_safe("death_" + last_direction)
	
	combat.set_process(false)

	set_physics_process(false)

	await get_tree().create_timer(2.0).timeout

	respawn()
	
	
func respawn():
	print("Respawn")

	is_dead = false
	is_attacking = false

	global_position = spawn_position

	stats.hp = stats.max_hp
	stats.mana = stats.max_mana
	
	combat.set_process(true)

	play_anim_safe("idle_" + last_direction)

	set_physics_process(true)

func _input(event):
	if event.is_action_pressed("ui_accept"):
		stats.take_damage(50)
