extends CharacterBody2D
class_name Player

const WEAPON_NONE = preload("res://resources/weapons/weapon_none.tres")
const WEAPON_KATANA = preload("res://resources/weapons/weapon_katana.tres")
const WEAPON_PISTOL = preload("res://resources/weapons/weapon_pistol.tres")
const WEAPON_SWORD = preload("res://resources/weapons/weapon_sword.tres")

var player_data: PlayerData

func _ready():
	player_data = preload("res://resources/player/player_data.tres")
	current_weapon_data = available_weapons[player_data.current_weapon_index]
	animated_sprite_2d.animation_finished.connect(_on_animated_sprite_2d_animation_finished)

@export var initial_weapon_index: int = 0

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var audio_position_2d: AudioPosition2D = $AudioPosition2D

@onready var damage_area_2d: Area2D = $DamageArea2D
@onready var katana_area_2d: Area2D = $KatanaArea2D
@onready var sword_area_2d: Area2D = $SwordArea2D

enum MovementState { IDLE, WALK, RUN, JUMP, FALLING, LAND, CROUCH_IDLE, CROUCH_WALK, DASH, ROLL, SLIDE, WALL_SLIDE, WALL_LAND, AIR_SPIN, LEDGE_GRAB_CLIMB, CLIMB_BACK, CLIMB_SIDE, PULL, PUSH, PUSH_IDLE }
enum ActionState { NONE, ATTACKING, INTERACTING, HURT, DEAD, AIMING, SHEATHE }

var current_movement_state: MovementState = MovementState.IDLE
var current_weapon_data: WeaponData # Reference to the currently equipped weapon's data
var current_action_state: ActionState = ActionState.NONE

var can_attack: bool = true
var attack_cooldown_timer: float = 0.0

var state_timer: float = 0.0
var dash_speed: float = 700.0
var dash_duration: float = 0.2
var roll_speed: float = 500.0
var roll_duration: float = 0.5
var slide_speed: float = 400.0
var slide_duration: float = 0.3

var available_weapons: Array[WeaponData] = [
	WEAPON_NONE,
	WEAPON_KATANA,
	WEAPON_SWORD,
	WEAPON_PISTOL
]

func take_damage(amount: float):
	if player_data.current_health <= 0:
		return

	player_data.current_health -= amount
	if player_data.current_health <= 0:
		player_data.current_health = 0
		set_action_state(ActionState.DEAD)
		print("Player died!")
	else:
		set_action_state(ActionState.HURT)
		print("Player took ", amount, " damage. Current health: ", player_data.current_health)
	_save_PLAYER_DATA()

func heal(amount: float):
	player_data.current_health += amount
	if player_data.current_health > player_data.max_health:
		player_data.current_health = player_data.max_health
	print("Player healed ", amount, ". Current health: ", player_data.current_health)
	_save_PLAYER_DATA()

func _save_PLAYER_DATA():
	var error = ResourceSaver.save(player_data, "res://resources/player/player_data.tres")
	if error != OK:
		printerr("Failed to save player data: ", error)
	else:
		print("Player data saved successfully.")

func _physics_process(delta: float) -> void:
	if player_data == null:
		return # Cannot process without player data

	var was_on_floor = is_on_floor()

	if state_timer > 0:
		state_timer -= delta
		if state_timer <= 0:
			state_timer = 0
			if current_movement_state == MovementState.DASH or \
			   current_movement_state == MovementState.ROLL or \
			   current_movement_state == MovementState.SLIDE:
				current_movement_state = MovementState.IDLE

	if attack_cooldown_timer > 0:
		attack_cooldown_timer -= delta
		if attack_cooldown_timer <= 0:
			can_attack = true

	if not is_on_floor():
		velocity.y += player_data.gravity_strength * delta

	if Input.is_action_just_pressed("move_up") and is_on_floor():
		velocity.y = player_data.jump_velocity

	var is_running = Input.is_action_pressed("move_run")

	# Block movement if attacking
	if current_action_state == ActionState.ATTACKING:
		velocity.x = 0
	else:
		match current_movement_state:
			MovementState.DASH:
				if velocity.x != 0:
					velocity.x = sign(velocity.x) * dash_speed
				else:
					velocity.x = 1 * dash_speed
				velocity.y = 0
			MovementState.ROLL:
				velocity.x = sign(velocity.x) * roll_speed
			MovementState.SLIDE:
				velocity.x = sign(velocity.x) * slide_speed
			_:
				var direction := Input.get_axis("move_left", "move_right")
				if direction:
					var speed = player_data.movement_speed
					if is_running:
						speed = player_data.run_speed
					velocity.x = direction * speed
					animated_sprite_2d.flip_h = direction < 0
				else:
					velocity.x = move_toward(velocity.x, 0, player_data.movement_speed)

	move_and_slide()

	update_movement_state(was_on_floor, is_running)
	update_animation()

func _input(event: InputEvent):
	if event.is_action_pressed("weapon_next"):
		_switch_weapon_next()
	if event.is_action_pressed("action_attack"):
	if can_attack and current_action_state == ActionState.NONE:
		set_action_state(ActionState.ATTACKING)
		can_attack = false
		attack_cooldown_timer = current_weapon_data.attack_cooldown
	if event.is_action_pressed("move_dash"):
		_try_dash()
	if event.is_action_pressed("move_roll"):
		_try_roll()
	if event.is_action_pressed("move_slide"):
		_try_slide()
	if event.is_action_pressed("move_climb"):
		_try_climb()
	if event.is_action_pressed("move_air_spin"):
		_try_air_spin()
	if event.is_action_pressed("action_interact"):
		set_action_state(ActionState.INTERACTING)
	if event.is_action_pressed("action_sheathe_weapon"):
		print("Sheathe/Unsheathe weapon")
	if event.is_action_pressed("action_pull"):
		_try_pull()
	if event.is_action_pressed("action_push"):
		_try_push()
	if event.is_action_pressed("weapon_previous"):
		_switch_weapon_previous()

func _switch_weapon_previous():
	if available_weapons.is_empty():
		printerr("No weapons available to switch!")
		return

	var current_index = available_weapons.find(current_weapon_data)
	var prev_index = (current_index - 1 + available_weapons.size()) % available_weapons.size()
	current_weapon_data = available_weapons[prev_index]
	player_data.current_weapon_index = prev_index
	_save_PLAYER_DATA()

func _switch_weapon_next():
	if available_weapons.is_empty():
		printerr("No weapons available to switch!")
		return

	var current_index = available_weapons.find(current_weapon_data)
	var next_index = (current_index + 1) % available_weapons.size()
	current_weapon_data = available_weapons[next_index]
	player_data.current_weapon_index = next_index
	_save_PLAYER_DATA()

func _try_dash():
	if current_action_state == ActionState.NONE:
		print("Dash initiated!")
		current_movement_state = MovementState.DASH
		state_timer = dash_duration
		if velocity.x != 0:
			velocity.x = sign(velocity.x) * dash_speed
		else:
			velocity.x = 1 * dash_speed

func _try_roll():
	if is_on_floor() and current_action_state == ActionState.NONE:
		print("Roll initiated!")
		current_movement_state = MovementState.ROLL
		state_timer = roll_duration
		velocity.x = sign(velocity.x) * roll_speed if velocity.x != 0 else 1 * roll_speed

func _try_slide():
	if is_on_floor() and current_action_state == ActionState.NONE:
		print("Slide initiated!")
		current_movement_state = MovementState.SLIDE
		state_timer = slide_duration
		velocity.x = sign(velocity.x) * slide_speed if velocity.x != 0 else 1 * slide_speed

func _try_climb():
	print("Climb initiated!")
	current_movement_state = MovementState.CLIMB_BACK

func _try_air_spin():
	print("Air Spin initiated!")
	current_movement_state = MovementState.AIR_SPIN

func _try_pull():
	print("Pull initiated!")
	current_movement_state = MovementState.PULL

func _try_push():
	print("Push initiated!")
	current_movement_state = MovementState.PUSH

func update_movement_state(was_on_floor: bool, is_running: bool):
	if state_timer > 0:
		return

	var new_state: MovementState

	if is_on_floor() and not was_on_floor:
		new_state = MovementState.LAND
	elif not is_on_floor():
		if is_on_wall():
			if velocity.y > 0:
				new_state = MovementState.WALL_SLIDE
			else:
				new_state = MovementState.JUMP
		elif velocity.y < 0:
			new_state = MovementState.JUMP
		elif velocity.y > 0:
			new_state = MovementState.FALLING
		else:
			new_state = MovementState.JUMP
	else:
		if Input.is_action_pressed("move_down"):
			if abs(velocity.x) > 0:
				new_state = MovementState.CROUCH_WALK
			else:
				new_state = MovementState.CROUCH_IDLE
		elif abs(velocity.x) > 0:
			if is_running:
				new_state = MovementState.RUN
			elif abs(velocity.x) > player_data.movement_speed:
				new_state = MovementState.RUN
			else:
				new_state = MovementState.WALK
		else:
			new_state = MovementState.IDLE

	if new_state != current_movement_state:
		current_movement_state = new_state

func set_action_state(new_state: ActionState):
	if current_action_state == ActionState.ATTACKING and animated_sprite_2d.is_playing():
		return # Cannot interrupt attack animation
	current_action_state = new_state

func update_animation():
	if not animated_sprite_2d:
		print("AnimatedSprite2D node not found!")
		return

	var base_anim_name = ""
	var current_anim = animated_sprite_2d.animation

	match current_action_state:
		ActionState.DEAD:
			base_anim_name = "death"
		ActionState.HURT:
			base_anim_name = "hurt_damaged"
		ActionState.ATTACKING:
			if current_weapon_data != null:
				if current_weapon_data.weapon_name == "Katana" and not is_on_floor():
					base_anim_name = "katana_air_attack"
				elif current_weapon_data.weapon_name == "Pistol" and abs(velocity.x) > 0:
					base_anim_name = "running_shooting"
				else:
					base_anim_name = current_weapon_data.attack_animation_name
			else:
				base_anim_name = "punch"
		ActionState.AIMING:
			base_anim_name = "running_aiming"
		ActionState.SHEATHE:
			if current_weapon_data != null and not current_weapon_data.sheathe_animation_name.is_empty():
				base_anim_name = current_weapon_data.sheathe_animation_name
			else:
				base_anim_name = "idle"
		ActionState.INTERACTING:
			pass
		_:
			pass

	if base_anim_name.is_empty():
		match current_movement_state:
			MovementState.IDLE:
				base_anim_name = current_weapon_data.idle_animation_name if current_weapon_data else "idle"
			MovementState.WALK:
				if current_weapon_data and not current_weapon_data.idle_animation_name.is_empty() and current_weapon_data.idle_animation_name != "idle":
					base_anim_name = current_weapon_data.idle_animation_name
				else:
					base_anim_name = "walk"
			MovementState.RUN:
				base_anim_name = current_weapon_data.run_animation_name if current_weapon_data else "run"
			MovementState.JUMP:
				base_anim_name = "jump"
			MovementState.FALLING:
				base_anim_name = "jump"
			MovementState.LAND:
				base_anim_name = "land"
			MovementState.CROUCH_IDLE:
				base_anim_name = "crouch_idle"
			MovementState.CROUCH_WALK:
				base_anim_name = "crouch_walk"
			MovementState.DASH:
				base_anim_name = "dash"
			MovementState.ROLL:
				base_anim_name = "roll"
			MovementState.SLIDE:
				base_anim_name = "slide"
			MovementState.WALL_SLIDE:
				base_anim_name = "wall_slide_left" if animated_sprite_2d.flip_h else "wall_slide"
			MovementState.WALL_LAND:
				base_anim_name = "wall_land_left" if animated_sprite_2d.flip_h else "wall_land"
			MovementState.AIR_SPIN:
				base_anim_name = "air_spin"
			MovementState.LEDGE_GRAB_CLIMB:
				base_anim_name = "ledge_grab_climb"
			MovementState.CLIMB_BACK:
				base_anim_name = "climb_facing_back_of_player"
			MovementState.CLIMB_SIDE:
				base_anim_name = "climb_facing_side_of_player"
			MovementState.PULL:
				base_anim_name = "pull"
			MovementState.PUSH:
				base_anim_name = "push"
			MovementState.PUSH_IDLE:
				base_anim_name = "pushpull_idle_state"
			_:
				base_anim_name = "idle"
	print("Base Animation Name: ", base_anim_name)

	if animated_sprite_2d.sprite_frames.has_animation(base_anim_name):
		if current_anim != base_anim_name:
			animated_sprite_2d.play(base_anim_name)
			print("Playing animation: ", base_anim_name)
	else:
		if current_anim != "idle":
			animated_sprite_2d.play("idle")
			print("Animation '", base_anim_name, "' not found. Falling back to 'idle'.")
		else:
			print("Animation '", base_anim_name, "' not found and already playing 'idle'.")
		printerr("Animation '", base_anim_name, "' not found. Falling back to 'idle'.")

func _on_animated_sprite_2d_animation_finished():
	if current_action_state == ActionState.ATTACKING:
		current_action_state = ActionState.NONE
		can_attack = true
