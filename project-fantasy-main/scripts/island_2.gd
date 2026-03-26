extends Node3D
@onready var static_body_3d_2: StaticBody3D = $island2/StaticBody3D2

func _ready() -> void:
	Dialogic.signal_event.connect(_on_dialogic_signal)
	if Vardump.recent_dialog == 14:
		Dialogic.start("dialog16EXTMountainRange")
		Vardump.recent_dialog = 16

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		Dialogic.start("dialog23EXTNewCountry")
		Vardump.recent_dialog = 23

func _on_area_3d_2_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		SceneMangager.change_scene("res://scenes/castle.tscn")

func _on_area_3d_3_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		SceneMangager.change_scene("res://scenes/mountain.tscn")

func _on_dialogic_signal(argument : String):
	if argument == "changescene12":
		SceneMangager.change_scene("res://scenes/hideout.tscn")
