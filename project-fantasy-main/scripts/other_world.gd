extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Vardump.recent_dialog == 24:
		Dialogic.start("dialog25EXTBetweenDimensions")
		Vardump.recent_dialog = 25

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		SceneMangager.change_scene("res://scenes/tower.tscn")
