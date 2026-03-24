extends Node3D

func _ready() -> void:
	if Vardump.recent_dialog == 8:
		Dialogic.start("dialog9EXTPlains")
		Vardump.recent_dialog = 9

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		SceneMangager.change_scene("res://scenes/shrine_2.tscn")

func _on_area_3d_2_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		Dialogic.start("dialog10Mountains")
		Vardump.recent_dialog = 10

func _on_cave_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		SceneMangager.change_scene_arg(-8, 1, 0, "res://scenes/cave_1.tscn")
