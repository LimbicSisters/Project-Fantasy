extends Node
var current_scene = "res://scenes/opening.tscn"
var current_loc = Vector3() # Current location of character in overworld
var player = null # Player node

# ------ CHANGE SCENE ARGS ------
# Change scene with arguments for location to go to
func change_scene_arg( locationX : float, locationY : float, locationZ : float, file):
	# Call deferred run changing scene
	call_deferred("changing_scene", file)
	# Wait for .1 seconds
	await get_tree().create_timer(.01).timeout
	# Set player to first node in player group
	player = get_tree().get_first_node_in_group("Player")
	# Set player position to new location
	player.global_position = Vector3(locationX, locationY, locationZ)
# ------ CHANGE SCENE ------
# Runs changing scene on idle time
func change_scene(file): call_deferred("changing_scene", file)

# ------ CHANGING SCENE ------
# Changes scene to flie given
func changing_scene(file): get_tree().change_scene_to_file(file)

# ------ READY ------
# Runs on startup
func _ready() -> void:
	# Wait for one second
	await get_tree().create_timer(1).timeout
	# Set player to first node in player group
	player = get_tree().get_first_node_in_group("Player")

# ------ PHYSICS PROCESS ------
# Runs 60 times a second
func _physics_process(_delta: float) -> void:
	if get_tree().current_scene != null:
		var scene = get_tree().current_scene.name
		# If player is not null
		if player != null and scene != "Combat":
			# Current location is set to player position
			current_loc = player.global_position
		if scene != "Combat":
			match scene:
				"Opening":
					current_scene = "res://scenes/opening.tscn"
				"Cutscene":
					current_scene = "res://scenes/cutscene.tscn"
				"Cave1":
					current_scene = "res://scenes/cave_1.tscn"
				"Shrine1":
					current_scene = "res://scenes/shrine_1.tscn"
				"Shrine2":
					current_scene = "res://scenes/shrine_2.tscn"
				"Shrine3":
					current_scene = "res://scenes/shrine_3.tscn"
				"ISLAND2":
					current_scene = "res://scenes/ISLAND2.tscn"
	# Otherwise
	else:
		# Wait 1 second
		await get_tree().create_timer(1).timeout
		# Set player to first node in player group
		player = get_tree().get_first_node_in_group("Player")
