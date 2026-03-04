extends Node3D

@onready var fallingblocks: Node3D = $cave1/fallingblocks
@onready var crystal: Node3D = $crystal
@onready var god: Node3D = $god

func _ready() -> void:
	Dialogic.signal_event.connect(_on_dialogic_signal)
	if Vardump.crystal1dialogran:
		crystal.visible = false
		god.visible = true
		Dialogic.start("dialog7Crystal1")

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player") and not Vardump.crystal1dialogran:
		Vardump.crystal1dialogran = true
		Dialogic.start("dialog6INTcrystal1")

func _on_dialogic_signal(argument : String):
	if argument == "breakpillar":
		fallingblocks.queue_free()
	if argument == "cloakedrun":
		pass
	if argument == "crystalshatter":
		crystal.visible = false
		god.play_anim("godidle")
		god.visible = true
	if argument == "changescene4":
		Vardump.recent_dialog = 6
		SceneMangager.change_scene("res://scenes/combat.tscn")
	if argument == "lightspawn":
		god.queue_free()
		Vardump.fireballunlock = true
		Vardump.healingunlock = true
	if argument == "changescenesomn":
		Vardump.recent_dialog = 7
		SceneMangager.change_scene("res://scenes/shrine_1.tscn")
