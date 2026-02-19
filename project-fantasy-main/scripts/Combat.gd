extends Node
class_name Combat

@onready var paulabel: Label = $UI/Paulabel
@onready var rykalabel: Label = $UI/Rykalabel
@onready var ryka_speed: ProgressBar = $UI/RykaSpeed
@onready var paul_speed: ProgressBar = $UI/PaulSpeed
@onready var enemieslabel: Label = $UI/Enemies
@onready var arrow: Sprite2D = $Arrows/PlaceholderArrow
@onready var arrow_2: Sprite2D = $Arrows/PlaceholderArrow2
@onready var arrow_3: Sprite2D = $Arrows/PlaceholderArrow3
@onready var arrow_4: Sprite2D = $Arrows/PlaceholderArrow4
@onready var arrow_5: Sprite2D = $Arrows/PlaceholderArrow5
@onready var enemy_1: Enemy = $Enemies/Enemy1
@onready var enemy_2: Enemy = $Enemies/Enemy2
@onready var enemy_3: Enemy = $Enemies/Enemy3
@onready var ryka: Node3D = $Ryka
@onready var paul: Node3D = $Paul
@onready var update_label: Label = $UI/UpdateLabel
@onready var pxp_label: Label = $UI/PXPLabel
@onready var rxp_label: Label = $UI/RXPLabel
@onready var bossarrow: Sprite2D = $Arrows/bossarrow
var HolyLightActive = false
var enemy_nodes = []
var ava_types = []
var enemycount
var enemies = []
var target
var players = [Paul, Ryka]
var active = false
var activeplayer
var targeting = false
var defeated = []
var victory = false
var ended = false
var setup = false
var boss = false

func _ready() -> void:
	ryka_speed.max_value = Ryka.maxspeed
	paul_speed.max_value = Paul.maxspeed
	choose_enemy_count()
	choose_ava_types()
	choose_enemy_type()
	enemy_1.visible(enemies[0])
	if enemies.size() >= 2:
		enemy_2.visible(enemies[1])
	if enemies.size() >= 3:
		enemy_3.visible(enemies[2])
	setup = true

func _process(delta: float) -> void:
	if not victory and setup:
		paul.play_anim("idle")
		ryka.play_anim("idle")
		update_enemy_label()
		paulabel.text = ("Paul     Health: " + str(Paul.health) + "/" + str(Paul.maxhealth))
		rykalabel.text = ("Ryka     Health: " + str(Ryka.health) + "/" + str(Ryka.maxhealth))
		if not active:
			for player in players:
				if not player.dead:
					player.speed -= 10 * delta
					match player:
						Paul:
							paul_speed.value = Paul.speed
						Ryka:
							ryka_speed.value = Ryka.speed
					if player.speed <= 0 and not active:
						player.speed = player.maxspeed
						active = true
						activeplayer = player
						update_label.text = (str(activeplayer.name) + " is active!")
						update_label.visible = true
						await get_tree().create_timer(1.5).timeout
						update_label.visible = false
			if enemy_nodes.size() <= 0:
				if not ended:
					end_combat()
			for enemy in enemy_nodes:
				enemy.speed -= 1 * delta
				if enemy.speed <= 0:
					enemy.speed = enemy.maxspeed
					var enemytarget
					if not Paul.dead and not Ryka.dead:
						enemytarget = match_target(randi_range(4, 5))
					elif Paul.dead:
						enemytarget = match_target(4)
					elif Ryka.dead:
						enemytarget = match_target(5)
					enemy.attack(enemytarget)
					if enemytarget.health <= 0:
						die(enemytarget)
					if Paul.dead and Ryka.dead:
						end_combat()
					

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		if victory:
			SceneMangager.change_scene_arg(SceneMangager.current_loc.x,SceneMangager.current_loc.y, SceneMangager.current_loc.z, SceneMangager.current_scene)
	if event.is_action_pressed("move_up"):
		if targeting:
			target = ArrowManager.move_arrow_up(HolyLightActive, enemy_1, enemy_2, enemy_3, Ryka, Paul, arrow, arrow_2, arrow_3, arrow_4, arrow_5, target, enemy_nodes)
	if event.is_action_pressed("move_down"):
		if targeting:
			target = ArrowManager.move_arrow_down(HolyLightActive, enemy_1, enemy_2, enemy_3, Ryka, Paul, arrow, arrow_2, arrow_3, arrow_4, arrow_5, target, enemy_nodes) 

func choose_enemy_count():
	if SceneMangager.current_scene == "res://scenes/cutscene.tscn" or SceneMangager.current_scene == "res://scenes/cave_1.tscn":
		match Vardump.recent_dialog:
			2:
				enemycount = 2
				enemy_nodes.append(enemy_1)
				enemy_1.dead = false
			6:
				enemycount = 2
				enemy_nodes.append(enemy_1)
				enemy_1.dead = false
	else:
		var num = randi_range(1, 6)
		if num == 6:
			enemycount = 4
			enemy_nodes.append(enemy_3)
			enemy_nodes.append(enemy_2)
			enemy_nodes.append(enemy_1)
			enemy_1.dead = false
			enemy_2.dead = false
			enemy_3.dead = false
		elif num >= 4:
			enemycount = 3
			enemy_nodes.append(enemy_2)
			enemy_nodes.append(enemy_1)
			enemy_1.dead = false
			enemy_2.dead = false
		else:
			enemycount = 2
			enemy_nodes.append(enemy_1)
			enemy_1.dead = false

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

func choose_enemy_type():
	for enemy in enemycount:
		if enemy != 0:
			enemies.append(ava_types.pick_random())

func _on_attack_pressed() -> void:
	if active:
		if boss and not targeting:
			target = 1
			bossarrow.visible = true
			targeting = true
		elif not targeting and not boss:
			targeting = true
			target = 5
			target = ArrowManager.move_arrow_down(HolyLightActive, enemy_1, enemy_2, enemy_3, Ryka, Paul, arrow, arrow_2, arrow_3, arrow_4, arrow_5, target, enemy_nodes) 
		else:
			active = false
			targeting = false
			var attacktarget = match_target(target)
			arrow_n_visible()
			match activeplayer:
				Paul:
					Paul.attack(attacktarget)
					if attacktarget.dead:
						die(attacktarget)
				Ryka:
					Ryka.attack(attacktarget)
					if attacktarget.dead:
						die(attacktarget)

func match_target(targetnum):
	match targetnum:
		1:
			return enemy_1
		2:
			return enemy_2
		3:
			return enemy_3
		4:
			return Ryka
		5:
			return Paul

func _on_power_pressed() -> void:
	if active:
		if targeting:
			active = false
			targeting = false
			var attacktarget = match_target(target)
			arrow_n_visible()
			match activeplayer:
				Paul:
					Paul.check_power(attacktarget)
					if attacktarget.dead:
						die(attacktarget)
				Ryka:
					Ryka.check_power(attacktarget)
					if attacktarget.dead:
						die(attacktarget)
		else:
			if activeplayer.equippedpower != "None":
				targeting = true
				target = 5
				target = ArrowManager.move_arrow_down(HolyLightActive, enemy_1, enemy_2, enemy_3, Ryka, Paul, arrow, arrow_2, arrow_3, arrow_4, arrow_5, target, enemy_nodes) 
			else:
				update_label.text = "You don't have a Power equipped!"
				update_label.visible = true
				await get_tree().create_timer(3).timeout
				update_label.visible = false
			if activeplayer == Paul and Paul.equippedpower == "HolyLight":
				HolyLightActive = true

func _on_run_pressed() -> void:
	if active:
		active = false
		if randi_range(1, 3) == 1:
			update_label.text = "You run away successfully!"
			update_label.visible = true
			await get_tree().create_timer(3).timeout
			update_label.visible = false
			SceneMangager.change_scene_arg(SceneMangager.current_loc.x, SceneMangager.current_loc.y,SceneMangager.current_loc.z, SceneMangager.current_scene)

func arrow_n_visible():
	arrow.visible = false
	arrow_2.visible = false
	arrow_3.visible = false
	arrow_4.visible = false
	arrow_5.visible = false
	bossarrow.visible = false

func update_enemy_label():
	var currenttext = "Enemies:"
	for enemy in enemies:
		currenttext += ("\n" + enemy)
	enemieslabel.text = currenttext

func end_combat():
	if players[0].dead and players[1].dead:
		Paul.health = Paul.maxhealth
		Ryka.health = Ryka.maxhealth
		ended = true
		if Vardump.recent_dialog == 2:
			SceneMangager.change_scene("res://scenes/cutscene.tscn")
		elif Vardump.recent_dialog == 6:
			SceneMangager.change_scene_arg(98, -29, 0.0, "res://scenes/cave_1.tscn")
		else:
			SceneMangager.change_scene("res://scenes/game_over.tscn")
	else:
		ended = true
		var rcurrent_text = """XP:
Ryka:\n"""
		var pcurrent_text = """XP:
Paul:\n"""
		for enemy in defeated:
			for player in players:
				var xp = randi_range(enemy.minxp, enemy.maxxp)
				player.XP += xp
				match player:
					Paul:
						pcurrent_text += (str(xp) + "\n")
					Ryka:
						rcurrent_text += (str(xp) + "\n")
		Paul.level_check(Paul.XP)
		Ryka.level_check(Ryka.XP)
		pcurrent_text += "\nLevel:\n" + str(Paul.level)
		rcurrent_text += "\nLevel:\n" + str(Ryka.level)
		pxp_label.text = pcurrent_text
		pxp_label.visible = true
		rxp_label.text = rcurrent_text
		rxp_label.visible = true
		victory = true
		update_label.text = "Press 'E' to exit"
		update_label.visible = true

func die(person):
	if person.dead:
		if person in enemy_nodes:
			enemy_nodes.erase(person)
			defeated.append(person)
			person.visible = false
		elif person in players:
			match person:
				Paul:
					paul.visible = false
				Ryka:
					ryka.visible = false
