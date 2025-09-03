@tool
extends Resource
class_name AudioConfig

signal config_changed

@export var music_data: Dictionary = {}
@export var sfx_data: Dictionary = {}

@export var sfx_paths: Array[String] = ["res://assets/sfx"]:
	set(value):
		if sfx_paths != value:
			sfx_paths = value
			_save_and_emit_changed()

@export var music_paths: Array[String] = ["res://assets/music"]:
	set(value):
		if music_paths != value:
			music_paths = value
			_save_and_emit_changed()

@export var default_click_key: String = "ui_click":
	set(value):
		if default_click_key != value:
			default_click_key = value
			_save_and_emit_changed()

@export var default_hover_key: String = "ui_hover":
	set(value):
		if default_hover_key != value:
			default_hover_key = value
			_save_and_emit_changed()

@export var default_slider_key: String = "ui_slider_changed":
	set(value):
		if default_slider_key != value:
			default_slider_key = value
			_save_and_emit_changed()

@export_group("Volume Settings")
@export_range(0.0, 1.0, 0.01) var master_volume: float = 1.0:
	set(value):
		if master_volume != value:
			master_volume = value
			_save_and_emit_changed()

@export_range(0.0, 1.0, 0.01) var sfx_volume: float = 1.0:
	set(value):
		if sfx_volume != value:
			sfx_volume = value
			_save_and_emit_changed()

@export_range(0.0, 1.0, 0.01) var music_volume: float = 1.0:
	set(value):
		if music_volume != value:
			music_volume = value
			_save_and_emit_changed()

enum PlaybackMode { SEQUENTIAL, RANDOM, REPEAT_ONE }

@export_group("Music Playlists")
@export var music_playlists: Dictionary = {}:
	set(value):
		if music_playlists != value:
			music_playlists = value
			_save_and_emit_changed()

func _save_and_emit_changed():
	# Notifica o editor que o recurso foi modificado
	emit_changed()
	emit_signal("config_changed")
