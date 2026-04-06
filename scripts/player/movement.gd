extends Node

var player

func setup(p):
	player = p

func get_input_vector():
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	return input_vector.normalized()

func handle_movement(input_vector):
	if input_vector != Vector2.ZERO:
		player.velocity = input_vector * player.speed
		player.update_last_direction(input_vector)
		player.play_anim_safe("walk_" + player.last_direction)
	else:
		player.velocity = Vector2.ZERO
		player.play_anim_safe("idle_" + player.last_direction)
