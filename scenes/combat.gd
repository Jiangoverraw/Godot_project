class_name Combat extends Node

var player: CharacterBody2D

func setup(p):
	player = p

func try_attack():
	if Input.is_action_just_pressed("attack") and !player.is_attacking:
		player.is_attacking = true
		
		player.play_anim_safe("attack_" + player.last_direction)
		
		await player.anim.animation_finished
		
		player.is_attacking = false
