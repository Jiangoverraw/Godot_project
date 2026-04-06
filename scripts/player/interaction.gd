extends Node

var player

func setup(p):
	player = p

func try_pickup(item):
	player.inventory.add_item(item)
	item.queue_free()
