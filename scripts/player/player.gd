extends CharacterBody2D
class_name Player

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var area_2d: Area2D = $Area2D
@onready var audio_position_2d: AudioPosition2D = $AudioPosition2D

enum MovementState { IDLE, WALK, RUN, JUMP }
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

func set_weapon_state(new_state: WeaponState):
	current_weapon_state = new_state
	match current_weapon_state:
		WeaponState.NONE:
			audio_position_2d.play_secondary_sound("weapon_none_sfx") # Usar play_secondary_sound para sons de arma
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
	if animated_sprite_2d:
		var anim_name = "idle"
		match current_movement_state:
			MovementState.WALK:
				anim_name = "walk"
			MovementState.RUN:
				anim_name = "run"
			MovementState.JUMP:
				anim_name = "jump"
		
		if animated_sprite_2d.animation != anim_name:
			animated_sprite_2d.play(anim_name)
