extends Node
class_name Player
@export_enum("Wooden", "Iron", "Steel", "Dragon", "Godly", "None") var Helmet = "None"
@export_enum("Wooden", "Iron", "Steel", "Dragon", "Godly", "None") var Chestplate = "None"
@export_enum("Wooden", "Iron", "Steel", "Dragon", "Godly", "None") var Leggings = "None"
@export_enum("Wooden", "Iron", "Steel", "Dragon", "Godly", "None") var Gloves = "None"
@export_enum("Wooden", "Iron", "Steel", "Dragon", "Godly", "None") var Boots = "None"
@export_enum("Sword", "Spear", "Axe", "Dagger", "None") var WeaponRType = "None"
@export_enum("Sword", "Dagger", "Shield", "None", "Taken") var WeaponLType = "None"
@export var maxhealth : int = 30
var health : int = maxhealth
var strength : float = 1
@export var level : int = 1
@export var XP : int = 1
var dead = false

func level_check(xp):
	if xp >= 800:
		level = 10
	elif xp >= 600:
		level = 9
	elif xp >= 425:
		level = 8
	elif xp >= 325:
		level = 7
	elif xp >= 250:
		level = 6
	elif xp >= 200:
		level = 5
	elif xp >= 150:
		level = 4
	elif xp >= 100:
		level = 3
	elif xp >= 50:
		level = 2
	else:
		level = 1

func attack(target):
	var damage = randi_range(1, 10) * strength
	if randi_range(1, 5) == 1:
		damage *= 2
	target.health -= damage
	if target.health <= 0:
		target.dead = true

func run():
	if randi_range(1, 3) == 1:
		return true
	return false

func up_stats():
	pass
