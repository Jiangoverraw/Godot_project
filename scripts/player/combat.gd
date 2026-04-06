extends Node

var player

func setup(p):
	player = p

func try_attack():
	if Input.is_action_just_pressed("mouse_button_left"):
		attack()

func attack():
	if player.is_attacking:
		return
	
	player.is_attacking = true
	player.velocity = Vector2.ZERO
	
	player.current_anim = "attack_" + player.last_direction
	player.anim.play(player.current_anim)
	
	await player.anim.animation_finished
	
	player.current_anim = ""
	player.is_attacking = false
