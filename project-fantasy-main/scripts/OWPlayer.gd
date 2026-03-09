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

func _on_paul_power_pressed() -> void:
	match Paul.equippedpower:
		"None":
			if Vardump.healingunlock:
				Paul.equippedpower = "Heal"
				you.text = "Paul now uses Heal!"
				you.visible = true
				await get_tree().create_timer(1.5).timeout
				you.visible = false
			else:
				you.text = "You don't have any power!"
				you.visible = true
				await get_tree().create_timer(1.5).timeout
				you.visible = false
		"Heal":
			if Vardump.lightningunlock:
				Paul.equippedpower = "Lightning"
				you.text = "Paul now uses Lightning!"
				you.visible = true
				await get_tree().create_timer(1.5).timeout
				you.visible = false
			else:
				Paul.equippedpower = "None"
				you.text = "Paul now uses nothing."
				you.visible = true
				await get_tree().create_timer(1.5).timeout
				you.visible = false
		"Lightning":
			if Vardump.holylightunlock:
				Paul.equippedpower = "HolyLight"
				you.text = "Paul now uses Holy Light!"
				you.visible = true
				await get_tree().create_timer(1.5).timeout
				you.visible = false
			else:
				Paul.equippedpower = "None"
				you.text = "Paul now uses nothing."
				you.visible = true
				await get_tree().create_timer(1.5).timeout
				you.visible = false
		"HolyLight":
			Paul.equippedpower = "None"
			you.text = "Paul now uses nothing."
			you.visible = true
			await get_tree().create_timer(1.5).timeout
			you.visible = false

func _on_ryka_power_pressed() -> void:
	match Ryka.equippedpower:
		"None":
			if Vardump.fireballunlock:
				Paul.equippedpower = "Fireball"
				you.text = "Ryka now uses Fireball!"
				you.visible = true
				await get_tree().create_timer(1.5).timeout
				you.visible = false
			else:
				you.text = "You don't have any power!"
				you.visible = true
				await get_tree().create_timer(1.5).timeout
				you.visible = false
		"Fireball":
			if Vardump.freezeunlock:
				Paul.equippedpower = "Freeze"
				you.text = "Ryka now uses Freeze!"
				you.visible = true
				await get_tree().create_timer(1.5).timeout
				you.visible = false
			else:
				Paul.equippedpower = "None"
				you.text = "Paul now uses nothing."
				you.visible = true
				await get_tree().create_timer(1.5).timeout
				you.visible = false
		"Freeze":
			if Vardump.ultimabeamunlock:
				Paul.equippedpower = "UltimaBeam"
				you.text = "Paul now uses Ultima Beam!"
				you.visible = true
				await get_tree().create_timer(1.5).timeout
				you.visible = false
			else:
				Paul.equippedpower = "None"
				you.text = "Paul now uses nothing."
				you.visible = true
				await get_tree().create_timer(1.5).timeout
				you.visible = false
		"UltimaBeam":
			Paul.equippedpower = "None"
			you.text = "Ryka now uses nothing."
			you.visible = true
			await get_tree().create_timer(1.5).timeout
			you.visible = false
