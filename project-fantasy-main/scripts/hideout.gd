extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Dialogic.signal_event.connect(_on_dialogic_signal)
	if Vardump.recent_dialog == 23 and not Vardump.JTCOMBAT and not Vardump.JTCOMBAT2:
		Dialogic.start("dialog24INTHideout")
		Vardump.JTCOMBAT = true
	elif Vardump.JTCOMBAT and not Vardump.JTCOMBAT2:
		Dialogic.start("dialog24INTHideout" , "COMBAT")
		Vardump.JTCOMBAT2 = true
	elif Vardump.JTCOMBAT and Vardump.JTCOMBAT2:
		Vardump.recent_dialog = 24
		Dialogic.start("dialog24INTHideout" , "COMBAT2")

func _on_dialogic_signal(argument: String):
	if argument == "changescene13":
		SceneMangager.change_scene("res://scenes/combat.tscn")
	if argument == "changescene14":
		SceneMangager.change_scene("res://scenes/combat.tscn")
	if argument == "changescene15":
		SceneMangager.change_scene("res://scenes/other_world.tscn")
	if argument == "powerlost":
		Vardump.fireballunlock = false
		Vardump.freezeunlock = false
		Vardump.healingunlock = false
		Vardump.lightningunlock = false
