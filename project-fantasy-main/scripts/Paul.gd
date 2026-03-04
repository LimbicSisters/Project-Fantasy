extends Player

@export_enum("None", "Heal", "Lightning", "HolyLight") var equippedpower : String = "None"
var maxspeed : float = 51.0
var speed : float = maxspeed

func heal(target):
	var potency = randi_range(1, 10) * strength
	if randi_range(1, 5) == 1:
		potency *= 2
	target.health += potency

func lightning(target):
	var damage = randi_range(1, 7) * strength
	if randi_range(1, 5) == 1:
		damage *= 2
	target.health -= damage
	if target.health <= 0:
		target.dead = true
	if randi_range(1, 3) == 1:
		return true
	return false

func holy_light_dam(target):
	var damage = randi_range(10, 17) * strength
	if randi_range(1, 5) == 1:
		damage *= 2
	target.health -= damage
	if target.health <= 0:
		target.dead = true
	if randi_range(1, 3) == 1:
		return true
	return false

func check_power(attacktarget):
	match equippedpower:
		"Heal":
			heal(attacktarget)
		"Lightning":
			lightning(attacktarget)
		"HolyLight":
			holy_light_dam(attacktarget)
