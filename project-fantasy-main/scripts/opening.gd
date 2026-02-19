extends Node3D

func _ready() -> void:
	if Vardump.recent_dialog == 3:
		Dialogic.start("dialog4OpenWorld")
		Vardump.recent_dialog = 4
