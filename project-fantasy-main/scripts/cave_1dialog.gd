extends Node3D

@onready var fallingblocks: Node3D = $cave1/fallingblocks
@onready var crystal: Node3D = $crystal
@onready var god: Node3D = $god
@onready var dialogtrigger_1: Area3D = $cave1/Dialogtrigger1

func _ready() -> void:
	Dialogic.signal_event.connect(_on_dialogic_signal)
	if Vardump.crystal1dialogran:
		crystal.visible = false
		god.visible = true
		Dialogic.start("dialog7Crystal1")
		Vardump.recent_dialog = 7

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player") and not Vardump.crystal1dialogran:
		Vardump.crystal1dialogran = true
		Dialogic.start("dialog6INTcrystal1")
		Vardump.recent_dialog = 6

func _on_dialogic_signal(argument : String):
	if argument == "breakpillar":
		fallingblocks.queue_free()
	if argument == "changescene4":
		SceneMangager.change_scene("res://scenes/combat.tscn")
	if argument == "lightspawn":
		god.queue_free()
		Vardump.fireballunlock = true
		Vardump.healingunlock = true
	if argument == "changescenesomn":
		SceneMangager.change_scene("res://scenes/shrine_1.tscn")
	if argument == "floordissolve":
		dialogtrigger_1.queue_free()

func _on_dialogtrigger_1_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		Dialogic.start("dialog4INTCAVES1")
		Vardump.recent_dialog = 4

func _on_dialogtrigger_2_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player") and Vardump.recent_dialog == 4:
		Vardump.recent_dialog = 5
		Dialogic.start("dialog5INTCAVES1")
