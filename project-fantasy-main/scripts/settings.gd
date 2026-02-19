extends Node2D
@onready var button: Button = $VBoxContainer/Fullscreenbutton
@onready var resolutionmenu: OptionButton = $VBoxContainer/resolutionmenu
@onready var scaleslider: HSlider = $VBoxContainer/Scaleslider
@onready var scalelabel: Label = $VBoxContainer/Scale
@onready var audio: Label = $VBoxContainer/Audio

func _ready() -> void:
	resolutionmenu.add_item("1280x720")
	resolutionmenu.add_item("1680x1050")
	resolutionmenu.add_item("1920x1080")
	resolutionmenu.add_item("3840x2160")
	resolutionmenu.selected = 2

func _on_go_back_pressed() -> void:
	SceneMangager.change_scene("res://scenes/main_menu.tscn")

func _on_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		button.text = "On"
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		button.text = "Off"

func _on_volumeslider_value_changed(value: float) -> void:
	audio.text = ("Audio: " + str(int(value)) + "%")
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)

func _on_resolutionmenu_item_selected(index: int) -> void:
	var selectedresolution : String = resolutionmenu.get_item_text(index)
	var resolutionnums : Array = selectedresolution.split("x")
	var width : int = int(resolutionnums[0])
	var height : int = int(resolutionnums[1])
	get_tree().root.size = Vector2(width, height)

func _on_scaleslider_value_changed(value: float) -> void:
	var resolutionscale = value/100.00
	var resolutionpercent = (str(int(value)) + "%")
	scalelabel.text = ("UI Scale: " + resolutionpercent)
	get_window().content_scale_factor = resolutionscale
