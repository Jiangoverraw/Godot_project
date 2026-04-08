extends CanvasLayer

@onready var grid = $Panel/GridContainer
var slot_scene = preload("res://scenes/ui/inventory/inventory_slot.tscn")

func _ready():
	refresh_inventory()

func refresh_inventory():
	for child in grid.get_children():
		child.queue_free()

	for item in InventoryManager.items:
		var slot = slot_scene.instantiate()
		grid.add_child(slot)
		slot.set_item(item)
