extends CharacterData
class_name PlayerData

@export var player_name: String = "Player"

# Experience/Leveling
@export var current_level: int = 1
@export var current_experience: float = 0.0
@export var experience_to_next_level: float = 100.0

# Resistances
@export var fire_resistance: float = 0.0
@export var ice_resistance: float = 0.0
@export var poison_resistance: float = 0.0

@export var movement_speed: float = 300.0 # Walk speed
@export var run_speed: float = 450.0 # Run speed
@export var jump_velocity: float = -400.0
@export var gravity_strength: float = 980.0
@export var current_weapon_index: int = 0

@export var available_animations: Array[String] = [
	"air_spin",
	"climb_facing_back_of_player",
	"climb_facing_side_of_player",
	"crouch_idle",
	"crouch_walk",
	"dash",
	"death",
	"hurt_damaged",
	"idle",
	"jump",
	"katana_air_attack",
	"katana_attack_sheathe",
	"katana_continuous_attack",
	"katana_run",
	"katana_run_attack",
	"katana_walk",
	"land",
	"ledge_grab_climb",
	"pull",
	"punch",
	"punch_cross",
	"punch_jab",
	"push",
	"pushpull_idle_state",
	"roll",
	"run",
	"running_aiming",
	"running_shooting",
	"shooting_two_handed",
	"slide",
	"sword_attack",
	"sword_idle",
	"sword_run",
	"sword_stab",
	"walk",
	"wall_land",
	"wall_land_left",
	"wall_slide",
	"wall_slide_left"
]
