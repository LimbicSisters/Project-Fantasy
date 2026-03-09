extends Node3D

@onready var crystal: Node3D = $crystal
@onready var player: Node3D = $Player

func _ready() -> void:
	Dialogic.signal_event.connect(_on_dialogic_signal)
	if Vardump.recent_dialog == 11 and not Vardump.dialog12ran:
		Dialogic.start("dialog12Crystal3")
		Vardump.recent_dialog = 12
		Vardump.dialog12ran = true
	elif Vardump.recent_dialog == 12 and not Vardump.dialog13ran:
		Dialogic.start("dialog13Crystal3")
		Vardump.recent_dialog = 13
		Vardump.dialog13ran = true
		crystal.visible = false
		player.visible = true
	elif Vardump.recent_dialog == 13 and not Vardump.dialog14ran:
		Dialogic.start("dialog14Crystal3")
		Vardump.recent_dialog = 14
		Vardump.dialog14ran = true

func _on_dialogic_signal(argument : String):
	if argument == "changescene5":
		SceneMangager.change_scene("res://scenes/combat.tscn")
	if argument == "changescene6":
		SceneMangager.change_scene("res://scenes/combat.tscn")
	if argument == "goddie":
		player.queue_free()

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		SceneMangager.change_scene("res://scenes/ISLAND2.tscn")
