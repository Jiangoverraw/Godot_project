extends Node2D

@onready var inventory_ui = $InventoryUI

var inventory_open := false

func _input(event):
	if event.is_action_pressed("inventory"):
		toggle_inventory()

func toggle_inventory():
	inventory_open = !inventory_open
	inventory_ui.visible = inventory_open

	# dừng game khi mở inventory
	get_tree().paused = inventory_open
