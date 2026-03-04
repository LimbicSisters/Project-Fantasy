extends Node3D
@onready var crystal: Node3D = $crystal
@onready var god: Node3D = $God

func _ready() -> void:
	Dialogic.signal_event.connect(_on_dialogic_signal)

func _on_dialogic_signal(argument):
	if argument == "crystalshatter2":
		crystal.visible = false
		god.visible = true
	if argument == "lightspawn2":
		god.queue_free()
	if argument == "changescenethingy":
		SceneMangager.change_scene("res://scenes/shrine_3.tscn")

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		Dialogic.start("dialog11Shrine2")
		Vardump.recent_dialog = 11
