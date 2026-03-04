extends Node
class_name Player
@export var maxhealth : int = 30
var health : int = maxhealth
var strength : float = 1
@export var level : int = 1
@export var XP : int = 1
var dead = false

func level_check(xp):
	if xp >= 800:
		level = 10
		up_stats()
	elif xp >= 600:
		level = 9
		up_stats()
	elif xp >= 425:
		level = 8
		up_stats()
	elif xp >= 325:
		level = 7
		up_stats()
	elif xp >= 250:
		level = 6
		up_stats()
	elif xp >= 200:
		level = 5
		up_stats()
	elif xp >= 150:
		level = 4
		up_stats()
	elif xp >= 100:
		level = 3
		up_stats()
	elif xp >= 50:
		level = 2
		up_stats()
	else:
		level = 1
		up_stats()

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
	match level:
		1:
			maxhealth = 30
			strength = 1
		2:
			maxhealth = 60
			strength = 2
		3:
			maxhealth = 90
			strength = 3
		4:
			maxhealth = 150
			strength = 5
		5:
			maxhealth = 250
			strength = 7
		6:
			maxhealth = 300
			strength = 10
		7:
			maxhealth = 450
			strength = 13
		8:
			maxhealth = 600
			strength = 15
		9:
			maxhealth = 800
			strength = 18
		10:
			maxhealth = 1000
			strength = 20
