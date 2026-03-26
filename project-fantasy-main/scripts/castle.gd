extends Node3D
@onready var staticb: StaticBody3D = $castle/StaticBody3D2


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Dialogic.signal_event.connect(_on_dialogic_signal)
	if Vardump.recent_dialog == 16:
		Vardump.recent_dialog = 17
		Dialogic.start("dialog17EXTCastleYard")
	if Vardump.recent_dialog >= 20:
		staticb.queue_free()

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player") and Vardump.recent_dialog == 17:
		Vardump.recent_dialog = 18
		Dialogic.start("dialog18INTCastle")
	elif body.is_in_group("Player") and Vardump.recent_dialog == 20:
		Vardump.recent_dialog = 21
		Dialogic.start("dialog21INTCastle")

func _on_area_3d_2_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		Vardump.recent_dialog = 22
		Dialogic.start("dialog22INTThroneRoom")

func _on_dialogic_signal(argument : String):
	if argument == "changesceneagain":
		SceneMangager.change_scene("res://scenes/mountain.tscn")
	if argument == "changescene11":
		SceneMangager.change_scene_arg(1.6, 1.0, -59.5, "res://scenes/ISLAND2.tscn")
