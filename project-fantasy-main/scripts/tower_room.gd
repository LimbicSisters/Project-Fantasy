extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Dialogic.signal_event.connect(_on_dialogic_signal)
	Dialogic.start("dialog29Tower")
	Vardump.recent_dialog = 29


func _on_dialogic_signal(argument : String):
	if argument == "changescene19":
		SceneMangager.change_scene("res://scenes/combat.tscn")
