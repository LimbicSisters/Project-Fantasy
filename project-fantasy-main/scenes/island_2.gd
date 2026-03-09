extends Node3D
@onready var static_body_3d_2: StaticBody3D = $island2/StaticBody3D2


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not Vardump.dialog16ran:
		Dialogic.start("dialog16EXTMountainRange")
		Vardump.dialog16ran = true
	if Vardump.dialog18ran:
		static_body_3d_2.queue_free()

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		pass

func _on_area_3d_2_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		pass

func _on_area_3d_3_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		pass
