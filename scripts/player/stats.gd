extends Node

@export var max_hp := 100
@export var max_mana := 50

var hp : int
var mana : int

func _ready():
	hp = max_hp
	mana = max_mana

func heal(amount):
	hp = clamp(hp + amount, 0, max_hp)
	print("HP:", hp)

func use_mana(cost):
	if mana >= cost:
		mana -= cost
		return true
	return false

func take_damage(dmg):
	hp = clamp(hp - dmg, 0, max_hp)
	print("HP:", hp)
