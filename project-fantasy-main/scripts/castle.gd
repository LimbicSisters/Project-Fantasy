extends Node3D
@onready var staticb: StaticBody3D = $castle/StaticBody3D2


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Dialogic.signal_event.connect(_on_dialogic_signal)
	if not Vardump.recent_dialog == 16:
		Dialogic.start("dialog17EXTCastleYard")
		Vardump.recent_dialog = 17
	if Vardump.recent_dialog >= 20:
		staticb.queue_free()

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player") and not Vardump.dialog18ran:
		Dialogic.start("dialog18INTCastle")
		Vardump.dialog18ran = true
	elif body.is_in_group("Player") and Vardump.dialog20ran:
		Dialogic.start("dialog21INTCastle")

func _on_area_3d_2_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		Dialogic.start("dialog22INTThroneRoom")

func _on_dialogic_signal(argument : String):
	if argument == "changesceneagain":
		SceneMangager.change_scene("res://scenes/mountain.tscn")
	if argument == "changescene11":
		SceneMangager.change_scene_arg(1.6, 1.0, -59.5, "res://scenes/ISLAND2.tscn")
