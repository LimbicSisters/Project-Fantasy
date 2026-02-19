extends Node
class_name Enemy

var health : int
var mindamage : int
var maxdamage : int
var maxspeed : float
var speed : float 
var minxp : int
var maxxp : int
var dead : bool

func set_stats(nhealth, nmindam, nmaxdam, nminxp, nmaxxp):
	health = nhealth
	mindamage = nmindam
	maxdamage = nmaxdam
	maxspeed = randf_range(4.0, 6.0)
	speed = maxspeed
	minxp = nminxp
	maxxp = nmaxxp

func visible(enemytype):
	for child in self.get_children():
		if child.name == enemytype:
			child.visible = true
			set_stats(child.nhealth, child.nmindam, child.nmaxdam, child.nminxp, child.nmaxxp)

func attack(target):
	var damage = randi_range(mindamage, maxdamage)
	if randi_range(1, 5) == 1:
		damage *= 2
	target.health -= damage
	if target.health <= 0:
		target.dead = true
