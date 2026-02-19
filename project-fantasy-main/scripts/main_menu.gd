extends Node2D

func _on_play_pressed() -> void:
	SceneMangager.change_scene("res://scenes/intro.tscn")

func _on_settings_pressed() -> void:
	SceneMangager.change_scene("res://scenes/settings.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
