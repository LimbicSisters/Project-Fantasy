extends CharacterBody3D

@onready var pause_menu: Node2D = $PauseMenu
@onready var player: Node3D = $Player
@onready var you: Label = $PauseMenu/You
const GRAVITY = -2000
const SPEED = 2
const RUNSPEED = 4
var running = false
var combatcooldown = 3.0
var maxcooldown = 1.0
var cooldown = 1.0
var walking
var activedialog = false
var paused = false

func _ready() -> void:
	combatcooldown = 3.0
	Dialogic.signal_event.connect(_on_dialogic_signal)
	remove_from_group("Player")
	add_to_group("Player")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("sprint"):
		running = true
	if event.is_action_released("sprint"):
		running = false
	if event.is_action_pressed("Pause"):
		if not paused:
			paused = true
			_on_dialogic_signal("lockmovement")
			pause_menu.visible = true
		else:
			paused = false
			_on_dialogic_signal("allowmovement")
			pause_menu.visible = false

func _on_dialogic_signal(argument : String):
	if argument == "allowmovement":
		activedialog = false
	if argument == "lockmovement":
		velocity.x = 0
		velocity.z = 0
		activedialog = true

func _physics_process(delta: float) -> void:
	if not activedialog and not paused:
		if combatcooldown > 0:
			combatcooldown -= 1 * delta
		else:
			cooldown -= 1 * delta
			if cooldown <= 0:
				cooldown = maxcooldown
				if try_combat():
					SceneMangager.change_scene("res://scenes/combat.tscn")
	if is_on_floor() and not activedialog:
		var input_dir = Input.get_vector("move_left", "move_right", "move_down", "move_up").normalized()
		if running:
			velocity.z = input_dir.x * RUNSPEED
			velocity.x = input_dir.y * RUNSPEED
		else:
			velocity.z = input_dir.x * SPEED
			velocity.x = input_dir.y * SPEED
		if velocity == Vector3(0, 0, 0):
			walking = false
			player.stop_anim()
		else:
			player.play_anim("Walk")
			walking = true
		var dir = atan2(input_dir.x, input_dir.y)
		player.global_rotation = Vector3(0, -dir, 0)
	elif not is_on_floor() and not activedialog:
		velocity = Vector3(0, GRAVITY * delta, 0)
		walking = false
	move_and_slide()

func try_combat():
	if running:
		if randi_range(1, 5) == 1:
			return true
	elif walking:
		if randi_range(1, 10) == 1:
			return true
	return false

func _on_menu_pressed() -> void:
	SceneMangager.change_scene("res://scenes/main_menu.tscn")
