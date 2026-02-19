extends Node3D

@onready var fallingblocks: Node3D = $cave1/fallingblocks
@onready var crystal: Node3D = $crystal
@onready var god: Node3D = $god

func _ready() -> void:
	Dialogic.signal_event.connect(_on_dialogic_signal)
	if Vardump.crystal1dialogran:
		crystal.visible = false
		god.visible = true
		Dialogic.start("dialog7PostCombat")

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player") and not Vardump.crystal1dialogran:
		Vardump.crystal1dialogran = true
		Dialogic.start("dialog6Crystal1")

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
	elif argument == "rykanim2":
		pass
	elif argument == "god1anim1":
		pass
	elif argument == "rykanim3":
		pass
	elif argument == "god1anim2":
		pass
	elif argument == "god1anim3":
		pass
	elif argument == "god1anim4":
		pass
	elif argument == "god1anim5":
		pass
	elif argument == "rykanim4":
		pass
	elif argument == "rykanim5":
		pass
	elif argument == "god1anim6":
		pass
	elif argument == "unlockpowers":
		pass
	elif argument == "lightspawn":
		pass
	elif argument == "changescene5":
		pass
