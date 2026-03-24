extends Node3D
class_name dialog

func _ready() -> void:
	Dialogic.signal_event.connect(_on_dialogic_signal)
	if Vardump.recent_dialog == 1:
		Vardump.recent_dialog = 2
		Dialogic.start("dialog2EXTSmallTown")
	elif Vardump.recent_dialog == 2:
		Vardump.recent_dialog = 3
		Dialogic.start("dialog3EXTSmallTown")

func _on_dialogic_signal(argument: String):
	if argument == "Changescene2":
		SceneMangager.change_scene("res://scenes/combat.tscn")
	elif argument == "Changescene3":
		SceneMangager.change_scene("res://scenes/opening.tscn")
