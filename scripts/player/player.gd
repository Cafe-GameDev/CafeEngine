extends CharacterBody2D
class_name Player

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var area_2d: Area2D = $Area2D
@onready var audio_position_2d: AudioPosition2D = $AudioPosition2D

enum MovementState { IDLE, WALK, RUN, JUMP, CROUCH_IDLE, CROUCH_WALK, DASH, ROLL, SLIDE, WALL_SLIDE, WALL_LAND, AIR_SPIN, LEDGE_GRAB_CLIMB, CLIMB_BACK, CLIMB_SIDE, PULL, PUSH, PUSH_IDLE }
enum WeaponState { NONE, SWORD, KATANA, PISTOL }
enum ActionState { NONE, ATTACKING, INTERACTING, HURT, DEAD }

var current_movement_state: MovementState = MovementState.IDLE
var current_weapon_state: WeaponState = WeaponState.NONE
var current_action_state: ActionState = ActionState.NONE

func _ready():
	pass

func _physics_process(_delta):
	update_movement_state()
	update_animation()

func update_movement_state():
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_direction * 100 # Exemplo de velocidade

	if velocity.length() > 0:
		if current_movement_state != MovementState.RUN:
			set_movement_state(MovementState.RUN)
	else:
		if current_movement_state != MovementState.IDLE:
			set_movement_state(MovementState.IDLE)

func set_movement_state(new_state: MovementState):
	current_movement_state = new_state
	match current_movement_state:
		MovementState.IDLE:
			audio_position_2d.set_state("player_idle_loop")
		MovementState.WALK:
			audio_position_2d.set_state("player_walk_loop")
		MovementState.RUN:
			audio_position_2d.set_state("player_run_loop")
		MovementState.JUMP:
			audio_position_2d.set_state("player_jump_sfx")
		# Add other movement states for sound if needed
		_:
			pass

func set_weapon_state(new_state: WeaponState):
	current_weapon_state = new_state
	match current_weapon_state:
		WeaponState.NONE:
			audio_position_2d.play_secondary_sound("weapon_none_sfx")
		WeaponState.SWORD:
			audio_position_2d.play_secondary_sound("weapon_sword_sfx")
		WeaponState.KATANA:
			audio_position_2d.play_secondary_sound("weapon_katana_sfx")
		WeaponState.PISTOL:
			audio_position_2d.play_secondary_sound("weapon_pistol_sfx")

func set_action_state(new_state: ActionState):
	current_action_state = new_state
	match current_action_state:
		ActionState.ATTACKING:
			audio_position_2d.play_secondary_sound("weapon_attack_sfx")
		ActionState.INTERACTING:
			audio_position_2d.play_secondary_sound("player_interact_sfx")
		ActionState.HURT:
			audio_position_2d.play_secondary_sound("player_hurt_sfx")
		ActionState.DEAD:
			audio_position_2d.play_secondary_sound("player_death_sfx")
		_:
			pass

func update_animation():
	if not animated_sprite_2d:
		return

	var base_anim_name = ""
	var current_anim = animated_sprite_2d.animation

	# Prioritize ActionState
	match current_action_state:
		ActionState.ATTACKING:
			match current_weapon_state:
				WeaponState.SWORD:
					base_anim_name = "sword_attack"
				WeaponState.KATANA:
					if current_movement_state == MovementState.RUN:
						base_anim_name = "katana_run_attack"
					else:
						base_anim_name = "katana_continuous_attack" # Or katana_attack_sheathe, depending on desired default
				WeaponState.PISTOL:
					if current_movement_state == MovementState.RUN:
						base_anim_name = "running_shooting"
					else:
						base_anim_name = "shooting_two_handed"
				_:
					base_anim_name = "punch" # Default attack if no weapon or unknown weapon
		ActionState.HURT:
			base_anim_name = "hurt_damaged"
		ActionState.DEAD:
			base_anim_name = "death"
		ActionState.INTERACTING:
			# Assuming no specific animation for interacting, or it's handled elsewhere
			pass
		_:
			# No specific action, proceed to weapon/movement states
			pass

	# If no action-specific animation, consider WeaponState + MovementState
	if base_anim_name == "":
		match current_weapon_state:
			WeaponState.SWORD:
				match current_movement_state:
					MovementState.IDLE:
						base_anim_name = "sword_idle"
					MovementState.WALK:
						base_anim_name = "sword_idle" # Assuming no sword_walk, fallback to sword_idle
					MovementState.RUN:
						base_anim_name = "sword_run"
					_:
						base_anim_name = "sword_idle"
			WeaponState.KATANA:
				match current_movement_state:
					MovementState.IDLE:
						base_anim_name = "katana_walk" # Assuming katana_walk is also for idle with katana
					MovementState.WALK:
						base_anim_name = "katana_walk"
					MovementState.RUN:
						base_anim_name = "katana_run"
					_:
						base_anim_name = "katana_walk"
			WeaponState.PISTOL:
				match current_movement_state:
					MovementState.IDLE:
						base_anim_name = "shooting_two_handed" # Assuming pistol idle is shooting_two_handed
					MovementState.WALK:
						base_anim_name = "running_aiming" # Assuming running_aiming is for pistol walk/run
					MovementState.RUN:
						base_anim_name = "running_aiming"
					_:
						base_anim_name = "shooting_two_handed"
			_:
				# No specific weapon, proceed to MovementState
				pass

	# If no weapon-specific animation, consider only MovementState
	if base_anim_name == "":
		match current_movement_state:
			MovementState.IDLE:
				base_anim_name = "idle"
			MovementState.WALK:
				base_anim_name = "walk"
			MovementState.RUN:
				base_anim_name = "run"
			MovementState.JUMP:
				base_anim_name = "jump"
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
				base_anim_name = "wall_slide"
			MovementState.WALL_LAND:
				base_anim_name = "wall_land"
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
				base_anim_name = "idle" # Fallback for unknown movement state

	# Ensure the animation exists before playing
	if animated_sprite_2d.sprite_frames.has_animation(base_anim_name):
		if current_anim != base_anim_name:
			animated_sprite_2d.play(base_anim_name)
	else:
		# Fallback if the constructed animation name doesn't exist
		if current_anim != "idle":
			animated_sprite_2d.play("idle")
		printerr("Animation '", base_anim_name, "' not found. Falling back to 'idle'.")
