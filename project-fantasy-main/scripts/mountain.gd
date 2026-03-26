extends Node3D

func _ready() -> void:
	Dialogic.signal_event.connect(_on_dialogic_signal)
	if Vardump.recent_dialog == 18 and not Vardump.dialog18ran:
		Vardump.dialog18ran = true
		Vardump.recent_dialog = 19
		Dialogic.start("dialog19EXTDragonMountain")
	elif Vardump.recent_dialog == 19 and Vardump.dialog18ran:
		Vardump.recent_dialog = 20
		Dialogic.start("dialog20EXTDragonMountain")


func _on_dialogic_signal(argument : String):
	if argument == "changescene8":
		SceneMangager.change_scene("res://scenes/combat.tscn")
	if argument == "changescene9":
		SceneMangager.change_scene("res://scenes/castle.tscn")
