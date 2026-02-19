extends Node3D

@export var file: String
@export var xloc: int
@export var yloc: int
@export var zloc: int

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		SceneMangager.change_scene_arg(xloc, yloc, zloc, file)
