extends CharacterBody2D

@export var speed := 200.0
@onready var anim = $AnimatedSprite2D

var last_direction := "down"
var is_attacking := false
var current_anim := ""  # FIX: tự track animation thay vì dùng anim.animation

func _physics_process(delta):
	if is_attacking:
		velocity = Vector2.ZERO
		move_and_slide()
		return

	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()

	# ===== ATTACK =====
	if Input.is_action_just_pressed("mouse_button_left"):
		start_attack()
		return

	# ===== MOVEMENT =====
	if input_vector != Vector2.ZERO:
		velocity = input_vector * speed
		update_last_direction(input_vector)
		play_anim_safe("walk_" + last_direction)
	else:
		velocity = Vector2.ZERO
		play_anim_safe("idle_" + last_direction)  # last_direction giữ nguyên hướng cuối

	move_and_slide()

# ===============================
# TRACK ANIMATION THỦ CÔNG
# ===============================
func play_anim_safe(anim_name: String):
	if current_anim != anim_name:
		current_anim = anim_name
		anim.play(anim_name)

# ===============================
# LƯU HƯỚNG DI CHUYỂN
# ===============================
func update_last_direction(dir: Vector2):
	if abs(dir.x) > abs(dir.y):
		last_direction = "right" if dir.x > 0 else "left"
	else:
		last_direction = "down" if dir.y > 0 else "up"

# ===============================
# ATTACK
# ===============================
func start_attack():
	is_attacking = true
	velocity = Vector2.ZERO
	current_anim = "attack_" + last_direction  # FIX: cập nhật tracker
	anim.play("attack_" + last_direction)
	await anim.animation_finished
	current_anim = ""  # FIX: reset để idle được trigger ngay sau attack
	is_attacking = false
