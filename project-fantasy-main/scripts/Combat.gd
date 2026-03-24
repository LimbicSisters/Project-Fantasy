extends Node

@onready var paulabel: Label = $UI/Paulabel
@onready var rykalabel: Label = $UI/Rykalabel
@onready var ryka_speed: ProgressBar = $UI/RykaSpeed
@onready var paul_speed: ProgressBar = $UI/PaulSpeed
@onready var arrow: Sprite2D = $Arrows/PlaceholderArrow
@onready var arrow_2: Sprite2D = $Arrows/PlaceholderArrow2
@onready var arrow_3: Sprite2D = $Arrows/PlaceholderArrow3
@onready var enemy_1: Node2D = $Enemies/Enemy1
@onready var enemy_2: Node2D = $Enemies/Enemy2
@onready var enemy_3: Node2D = $Enemies/Enemy3
@onready var ryka: Player = $Ryka
@onready var paul: Player = $Paul
@onready var update_label: Label = $UI/UpdateLabel
@onready var pxp_label: Label = $UI/PXPLabel
@onready var rxp_label: Label = $UI/RXPLabel
@onready var bossarrow: Sprite2D = $Arrows/bossarrow
@onready var arrows = [arrow, arrow_2, arrow_3, bossarrow]
@onready var players = [paul, ryka]
var enemy_nodes = []
var ava_types = []
var enemycount
var target
var active = false
var activeplayer
var targeting = false
var defeated = []
var victory = false
var setup = false
var boss = false

func _ready() -> void:
	paul.level_check(Vardump.PaulXP)
	ryka.level_check(Vardump.RykaXP)
	ryka_speed.max_value = ryka.maxspeed
	paul_speed.max_value = paul.maxspeed
	for player in players:
		player.speed = player.maxspeed
	choose_ava_types()
	choose_enemy_count()
	choose_enemy_type()
	enemy_nodes[0].dead = false
	if enemy_nodes.size() >= 2:
		enemy_nodes[1].dead = false
	if enemy_nodes.size() >= 3:
		enemy_nodes[2].dead = false
	setup = true

func _process(delta: float) -> void:
	if not victory and setup:
		paulabel.text = ("Paul     Health: " + str(paul.health) + "/" + str(paul.maxhealth))
		rykalabel.text = ("Ryka     Health: " + str(ryka.health) + "/" + str(ryka.maxhealth))
		if not active:
			for player in players:
				if not player.dead:
					player.speed -= 10 * delta
					match player:
						paul:
							paul_speed.value = paul.speed
						ryka:
							ryka_speed.value = ryka.speed
					if player.speed <= 0 and not active:
						player.speed = player.maxspeed
						active = true
						activeplayer = player
						update_label.text = (str(activeplayer.name) + " is active!")
						update_label.visible = true
						await get_tree().create_timer(1.5).timeout
						update_label.visible = false
			if enemy_nodes.size() == defeated.size():
				if not victory:
					end_combat()
			for enemy in enemy_nodes:
				enemy.speed -= 1 * delta
				if enemy.speed <= 0:
					enemy.speed = enemy.maxspeed
					var enemytarget
					if not paul.dead and not ryka.dead:
						enemytarget = match_target(randi_range(4, 5))
					elif paul.dead:
						enemytarget = match_target(4)
					elif ryka.dead:
						enemytarget = match_target(5)
					enemy.attack(enemytarget)
					if enemytarget.health <= 0:
						die(enemytarget)
					if paul.dead and ryka.dead:
						end_combat()
					

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		if victory:
			if Vardump.recent_dialog != 29:
				SceneMangager.change_scene_arg(SceneMangager.current_loc.x,SceneMangager.current_loc.y, SceneMangager.current_loc.z, SceneMangager.current_scene)
			else:
				SceneMangager.change_scene("res://scenes/the_end.tscn")
	if event.is_action_pressed("move_up"):
		if targeting and not boss:
			target = ArrowManager.move_arrow_up(enemy_nodes, arrow, arrow_2, arrow_3, target)
	if event.is_action_pressed("move_down"):
		if targeting and not boss:
			target = ArrowManager.move_arrow_down(enemy_nodes, arrow, arrow_2, arrow_3, target) 

func choose_enemy_count():
	if boss:
		enemycount = 2
	else:
		var num = randi_range(1, 6)
		if num == 6:
			enemycount = 4
		elif num >= 4:
			enemycount = 3
		else:
			enemycount = 2

func choose_ava_types():
	match SceneMangager.current_scene:
		"res://scenes/cutscene.tscn":
			boss = true
			ava_types.append("Fireman")
		"res://scenes/opening.tscn":
			ava_types.append("Goblin")
		"res://scenes/cave_1.tscn":
			if Vardump.recent_dialog == 6:
				boss = true
				ava_types.append("God")
			else:
				ava_types.append("Goblin")
		"res://scenes/shrine_1.tscn":
			ava_types.append("Goblin")
		"res://scenes/shrine_2.tscn":
			ava_types.append("Goblin")
		"res://scenes/shrine_3.tscn":
			match Vardump.recent_dialog:
				12:
					boss = true
					ava_types.append("CloakedMan")
				13:
					boss = true
					ava_types.append("God")
				_:
					ava_types.append("Goblin")
		"res://scenes/ISLAND2.tscn":
			ava_types.append("GoblinWarrior")
		"res://scenes/castle.tscn":
			ava_types.append("GoblinWarrior")
			ava_types.append("GoblinChief")
		"res://scenes/hideout.tscn":
			if Vardump.JTCOMBAT and not Vardump.JTCOMBAT2:
				boss = true
				ava_types.append("CloakedMan")
			elif Vardump.JTCOMBAT and Vardump.JTCOMBAT2:
				boss = true
				ava_types.append("Fireman")
		"res://scenes/tower_room.tscn":
			boss = true
			ava_types.append("OldOne")
		"res://scenes/other_world.tscn":
			ava_types.append("GoblinChief")
		"res://scenes/tower.tscn":
			ava_types.append("GoblinChief")

func choose_enemy_type():
	var type2
	var type3
	for enemy in enemycount:
		var type1 = ava_types.pick_random()
		if enemycount >= 3:
			type2 = ava_types.pick_random()
		if enemycount == 4:
			type3 = ava_types.pick_random()
		match enemy: 
			1:
				match type1:
					"Goblin":
						enemy_nodes.append(enemy_1.get_child(0))
						enemy_1.get_child(0).visible = true
					"Fireman":
						enemy_nodes.append(enemy_1.get_child(2))
						enemy_1.get_child(2).visible = true
					"God":
						enemy_nodes.append(enemy_1.get_child(1))
						enemy_1.get_child(1).visible = true
					"CloakedMan":
						enemy_nodes.append(enemy_1.get_child(3))
						enemy_1.get_child(3).visible = true
					"OldOne":
						enemy_nodes.append(enemy_1.get_child(4))
						enemy_1.get_child(4).visible = true
					"GoblinWarrior":
						enemy_nodes.append(enemy_3.get_child(5))
						enemy_3.get_child(5).visible = true
					"GoblinChief":
						enemy_nodes.append(enemy_3.get_child(6))
						enemy_3.get_child(6).visible = true
			2:
				match type2:
					"Goblin":
						enemy_nodes.append(enemy_2.get_child(0))
						enemy_2.get_child(0).visible = true
					"GoblinWarrior":
						enemy_nodes.append(enemy_3.get_child(1))
						enemy_3.get_child(1).visible = true
					"GoblinChief":
						enemy_nodes.append(enemy_3.get_child(2))
						enemy_3.get_child(2).visible = true
			3:
				match type3:
					"Goblin":
						enemy_nodes.append(enemy_3.get_child(0))
						enemy_3.get_child(0).visible = true
					"GoblinWarrior":
						enemy_nodes.append(enemy_3.get_child(1))
						enemy_3.get_child(1).visible = true
					"GoblinChief":
						enemy_nodes.append(enemy_3.get_child(2))
						enemy_3.get_child(2).visible = true

func _on_attack_pressed() -> void:
	if active:
		if boss and not targeting:
			target = 1
			bossarrow.visible = true
			targeting = true
		elif not targeting and not boss:
			targeting = true
			if not enemy_nodes[0].dead:
				arrow.visible = true
				target = 1
			elif not enemy_nodes[1].dead:
				arrow_2.visible = true
				target = 2
			else:
				arrow_3.visible = true
				target = 3
		else:
			active = false
			targeting = false
			var attacktarget = match_target(target)
			for earrow in arrows:
				earrow.visible = false
			match activeplayer:
				paul:
					paul.attack(attacktarget)
					if attacktarget.health <= 0:
						attacktarget.dead = true
						attacktarget.visible = false
						defeated.append(attacktarget)
				ryka:
					ryka.attack(attacktarget)
					if attacktarget.health <= 0:
						attacktarget.dead = true
						attacktarget.visible = false
						defeated.append(attacktarget)

func match_target(targetnum):
	match targetnum:
		1:
			return enemy_nodes[0]
		2:
			return enemy_nodes[1]
		3:
			return enemy_nodes[2]
		4:
			return ryka
		5:
			return paul

func _on_run_pressed() -> void:
	if active and not boss:
		active = false
		if randi_range(1, 3) == 1:
			update_label.text = "You run away successfully!"
			update_label.visible = true
			await get_tree().create_timer(3).timeout
			update_label.visible = false
			SceneMangager.change_scene_arg(SceneMangager.current_loc.x, SceneMangager.current_loc.y,SceneMangager.current_loc.z, SceneMangager.current_scene)
func end_combat():
	if players[0].dead and players[1].dead:
		for player in players:
			player.health = player.maxhealth
			player.dead = false
		victory = true
		if boss:
			if Vardump.recent_dialog == 2:
				SceneMangager.change_scene("res://scenes/cutscene.tscn")
			elif Vardump.recent_dialog == 6:
				SceneMangager.change_scene_arg(98, -29, 0.0, "res://scenes/cave_1.tscn")
			else:
				SceneMangager.change_scene("res://scenes/game_over.tscn")
	else:
		victory = true
		var rcurrent_text = """XP:
Ryka:\n"""
		var pcurrent_text = """XP:
Paul:\n"""
		for enemy in defeated:
			for player in players:
				var xp = randi_range(enemy.minxp, enemy.maxxp)
				match player:
					paul:
						Vardump.PaulXP += xp
						pcurrent_text += (str(xp) + "\n")
						paul.level_check(Vardump.PaulXP)
					ryka:
						Vardump.RykaXP += xp
						rcurrent_text += (str(xp) + "\n")
						ryka.level_check(Vardump.RykaXP)
				player.dead = false
		pcurrent_text += "\nXP: " + str(Vardump.PaulXP) + "\nLevel:\n" + str(paul.level)
		rcurrent_text += "\nXP: " + str(Vardump.RykaXP) + "\nLevel:\n" + str(ryka.level)
		pxp_label.text = pcurrent_text
		pxp_label.visible = true
		rxp_label.text = rcurrent_text
		rxp_label.visible = true
		update_label.text = "Press 'E' to exit"
		update_label.visible = true

func die(person):
	person.dead = true
	if person in players:
		match person:
			paul:
				paul.visible = false
			ryka:
				ryka.visible = false
