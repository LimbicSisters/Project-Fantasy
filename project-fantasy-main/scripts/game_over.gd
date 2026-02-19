extends Node2D

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		SceneMangager.change_scene("res://scenes/main_menu.tscn")
