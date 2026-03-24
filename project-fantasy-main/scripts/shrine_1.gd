extends Node3D

func _ready() -> void:
	if Vardump.recent_dialog == 7:
		Dialogic.start("dialog8INTShrine1")
		Vardump.recent_dialog = 8

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		SceneMangager.change_scene_arg(-17.0, 1.0, -2.0, "res://scenes/opening.tscn")
