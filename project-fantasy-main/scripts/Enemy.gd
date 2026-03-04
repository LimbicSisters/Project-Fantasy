extends Sprite2D
class_name Enemy

@export var health : int
@export var mindamage : int
@export var maxdamage : int
@export var maxspeed : float
@export var speed : float 
@export var minxp : int
@export var maxxp : int
var dead : bool = false

func attack(target):
	var damage = randi_range(mindamage, maxdamage)
	if randi_range(1, 5) == 1:
		damage *= 2
	target.health -= damage
	if target.health <= 0:
		target.dead = true
