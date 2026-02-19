extends Node3D
class_name dialog
@onready var fireman: Node3D = $Fireman
@onready var paul: Node3D = $Paul
@onready var ryka: Node3D = $Ryka
@onready var paulanim: AnimationPlayer = $Paul/Paulanim
@onready var rykanim: AnimationPlayer = $Ryka/Rykanim
@onready var fireanim: AnimationPlayer = $Fireman/fireanim

func _ready() -> void:
	Dialogic.signal_event.connect(_on_dialogic_signal)
	if Vardump.recent_dialog == 1:
		Dialogic.start("dialog2IntroCutscene")
	elif Vardump.recent_dialog == 2:
		Dialogic.start("dialog3PostCombat")

func _on_dialogic_signal(argument: String):
	if argument == "fireanim1":
		fireman.play_anim("fireman1")
	elif argument == "paulanim1":
		paul.play_anim("Walk")
		paulanim.play("move1")
		await get_tree().create_timer(.5).timeout
		paul.stop_anim()
	elif argument == "rykanim1":
		ryka.play_anim("Walk")
		rykanim.play("move1")
		await get_tree().create_timer(.5).timeout
		ryka.stop_anim()
	elif argument == "fireanim2":
		fireman.play_anim("fireman2")
	elif argument == "fireanim3":
		fireman.play_anim("fireman3")
	elif argument == "changescene2":
		Vardump.recent_dialog = 2
		SceneMangager.change_scene("res://scenes/combat.tscn")
	elif argument == "fireanim4":
		fireman.play_anim("fireanim4")
		paul.play_anim("pauldefeated")
		ryka.play_anim("pauldefeated")
		ryka.global_position = Vector3(26.5, 6, 20)
		paul.global_position = Vector3(26, 6, 17)
	elif argument == "fireanim5":
		fireman.play_anim("fireanim5")
	elif argument == "fireanim6":
		fireman.play_anim("fireanim6")
		fireanim.play("fly")
	elif argument == "changescene3":
		Vardump.recent_dialog = 3
		SceneMangager.change_scene("res://scenes/opening.tscn")
