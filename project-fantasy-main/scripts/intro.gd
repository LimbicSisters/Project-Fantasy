extends Node2D

func _ready() -> void:
	Dialogic.signal_event.connect(_on_dialogic_signal)
	Dialogic.start("dialog1EXTVoid")

func _on_dialogic_signal(argument : String):
	if argument == "Changescene1":
		Vardump.recent_dialog = 1
		await get_tree().create_timer(1).timeout
		SceneMangager.change_scene("res://scenes/cutscene.tscn")
