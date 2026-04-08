extends Button

@onready var icon_rect = $TextureRect
var item : Item

func set_item(new_item: Item):
	item = new_item
	icon_rect.texture = item.icon

func _pressed():
	if item:
		use_item()

func use_item():
	var player = get_tree().get_first_node_in_group("player")
	var stats = player.get_node("Stats")

	print("Used item:", item.name)

	if item.name == "Health Potion":
		stats.heal(25)
