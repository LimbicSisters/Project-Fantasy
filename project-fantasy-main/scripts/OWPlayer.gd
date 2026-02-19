extends CharacterBody3D

@onready var player: Node3D = $Player
const GRAVITY = -2000
const SPEED = 2
const RUNSPEED = 4
var running = false
var maxcooldown = 1.0
var cooldown = 1.0
var walking
var activedialog = false

func _ready() -> void:
	Dialogic.signal_event.connect(_on_dialogic_signal)
	remove_from_group("Player")
	add_to_group("Player")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("sprint"):
		running = true
	if event.is_action_released("sprint"):
		running = false

func _on_dialogic_signal(argument : String):
	if argument == "allowmovement":
		activedialog = false
	if argument == "lockmovement":
		velocity.x = 0
		velocity.z = 0
		activedialog = true

func _physics_process(delta: float) -> void:
	#if not activedialog and not Vardump.paused:
		#cooldown -= 1 * delta
		#if cooldown <= 0:
			#cooldown = maxcooldown
			#if try_combat():
				#SceneMangager.change_scene("res://scenes/combat.tscn")
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
