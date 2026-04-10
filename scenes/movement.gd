class_name Movement extends Node

var player: CharacterBody2D

func setup(p):
	player = p

func get_input_vector() -> Vector2:
	var input_vector = Vector2.ZERO
	
	input_vector.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input_vector.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	
	return input_vector.normalized()

func handle_movement(input_vector: Vector2):
	player.velocity = input_vector * player.speed
	
	# Update hướng cuối
	if input_vector != Vector2.ZERO:
		player.update_last_direction(input_vector)
		player.play_anim_safe("walk_" + player.last_direction)
	else:
		player.play_anim_safe("idle_" + player.last_direction)
