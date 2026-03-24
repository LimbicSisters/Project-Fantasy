extends Node3D

func _ready() -> void:
	Dialogic.signal_event.connect(_on_dialogic_signal)
	if Vardump.recent_dialog == 18:
		Dialogic.start("dialog19EXTDragonMountain")
		Vardump.recent_dialog = 19
	elif Vardump.recent_dialog == 19:
		Dialogic.start("dialog19EXTDragonMountain")
		Vardump.recent_dialog = 20


func _on_dialogic_signal(argument : String):
	if argument == "changescene8":
		SceneMangager.change_scene("res://scenes/combat.tscn")
	if argument == "changescene9":
		SceneMangager.change_scene("res://scenes/castle.tscn")
