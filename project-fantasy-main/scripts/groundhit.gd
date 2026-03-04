extends Area3D
var played = false

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player") and not played:
		played = true
		Dialogic.start("dialog5INTCAVES1")
