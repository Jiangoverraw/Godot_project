extends Node

var items := []

func add_item(item):
	items.append(item)
	print("Picked:", item)

func use_item(item):
	if item in items:
		items.erase(item)
		return true
	return false
