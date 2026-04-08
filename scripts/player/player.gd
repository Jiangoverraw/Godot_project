extends CharacterBody2D

@export var speed := 200.0
@onready var anim = $AnimatedSprite2D

# ===== COMPONENTS =====
@onready var movement = $Movement
@onready var combat = $Combat
@onready var stats = $Stats
# ===== PLAYER STATE =====
var last_direction := "down"
var is_attacking := false
var current_anim := ""

# ======
# READY 
# ======
func _ready():
	movement.setup(self)
	combat.setup(self)

# =====================================================
# MAIN LOOP
# =====================================================
func _physics_process(delta):

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
