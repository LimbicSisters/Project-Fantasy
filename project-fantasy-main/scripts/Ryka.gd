extends Player

@export_enum("None", "Fireball", "Freeze", "UltimaBeam") var equippedpower : String = "None"
var maxspeed : float = 50.0
var speed : float = maxspeed

func fireball(target):
	var damage = randi_range(1, 7) * strength
	if randi_range(1, 5) == 1:
		damage *= 2
	target.health -= damage
	if target.health <= 0:
		target.dead = true
	if randi_range(1, 3) == 1:
		return true
	return false

func Freeze(target):
	var damage = randi_range(1, 3) * strength
	if randi_range(1, 5) == 1:
		damage *= 2
	target.health -= damage
	if target.health <= 0:
		target.dead = true
	if randi_range(1, 3) == 1:
		return true
	return false

func Ultima_beam(target):
	var damage = randi_range(10, 17) * strength
	if randi_range(1, 5) == 1:
		damage *= 2
	target.health -= damage
	if target.health <= 0:
		target.dead = true
	if randi_range(1, 3) == 1:
		return true
	return false

func check_power(target):
	match equippedpower:
		"Fireball":
			fireball(target)
		"Freeze":
			Freeze(target)
		"UltimaBeam":
			Ultima_beam(target)
