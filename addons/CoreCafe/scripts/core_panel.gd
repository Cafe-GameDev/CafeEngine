@tool
extends VBoxContainer

const CORE_CONFIG_PATH = "res://addons/CoreCafe/resources/core_config.tres"

const MODULES = {
	"DataStore": {"path": "res://addons/CoreCafe/autoloads/data/data_store.gd", "panel_path": "res://addons/CoreCafe/scenes/data/data_panel.tscn", "config_property": "enable_data"},
	"SaveSystem": {"path": "res://addons/CoreCafe/autoloads/save/save_system.gd", "panel_path": "res://addons/CoreCafe/scenes/save/save_panel.tscn", "config_property": "enable_save"},
	"ConsoleDebug": {"path": "res://addons/CoreCafe/autoloads/console/console_debug.gd", "panel_path": "res://addons/CoreCafe/scenes/console/console_panel.tscn", "config_property": "enable_console"},
	"TestsRunner": {"path": "res://addons/CoreCafe/autoloads/tests/tests_runner.gd", "panel_path": "res://addons/CoreCafe/scenes/tests/tests_panel.tscn", "config_property": "enable_tests"},
	"MobileInput": {"path": "res://addons/CoreCafe/autoloads/mobile/mobile_input.gd", "panel_path": "res://addons/CoreCafe/scenes/mobile/mobile_panel.tscn", "config_property": "enable_mobile"},
	"DialogueFlow": {"path": "res://addons/CoreCafe/autoloads/dialogue/dialogue_flow.gd", "panel_path": "res://addons/CoreCafe/scenes/dialogue/dialogue_panel.tscn", "config_property": "enable_dialogue"},
	"CameraControl": {"path": "res://addons/CoreCafe/autoloads/camera/camera_control.gd", "panel_path": "res://addons/CoreCafe/scenes/camera/camera_panel.tscn", "config_property": "enable_camera"},
	"DisplayUI": {"path": "res://addons/CoreCafe/autoloads/display/display_ui.gd", "panel_path": "res://addons/CoreCafe/scenes/display/display_panel.tscn", "config_property": "enable_display"},
	"GameSettings": {"path": "res://addons/CoreCafe/autoloads/settings/gamesettings.gd", "panel_path": "res://addons/CoreCafe/scenes/settings/settings_panel.tscn", "config_property": "enable_settings"},
	"SceneTransition": {"path": "res://addons/CoreCafe/autoloads/transition/scene_transition.gd", "panel_path": "res://addons/CoreCafe/scenes/transition/transition_panel.tscn", "config_property": "enable_transition"},
	"PoolObject": {"path": "res://addons/CoreCafe/autoloads/pool/pool_object.gd", "panel_path": "res://addons/CoreCafe/scenes/pool/pool_panel.tscn", "config_property": "enable_pool"},
	"EventControl": {"path": "res://addons/CoreCafe/autoloads/event/event_control.gd", "panel_path": "res://addons/CoreCafe/scenes/event/event_panel.tscn", "config_property": "enable_event"},
}

@onready var plugins_tab: VBoxContainer = $TabContainer/PluginsTab

var core_config: CoreConfig
var plugin_ref: EditorPlugin
var cafe_panel_ref: VBoxContainer
var instantiated_panels = {}

func set_plugin_reference(plugin: EditorPlugin):
	plugin_ref = plugin

func set_cafe_panel_reference(panel: VBoxContainer):
	cafe_panel_ref = panel

func _ready():
	_load_or_create_config()
	_populate_plugins_tab()
	_update_autoloads_and_panels()

func _load_or_create_config():
	if ResourceLoader.exists(CORE_CONFIG_PATH):
		core_config = load(CORE_CONFIG_PATH)
		if core_config != null:
			return
	push_error("Falha ao carregar CoreConfig.tres. Criando um novo.")

	core_config = CoreConfig.new()
	var err = ResourceSaver.save(core_config, CORE_CONFIG_PATH)
	if err != OK:
		push_error("Nao foi possivel salvar o novo CoreConfig.tres")
		return
	
	for module_name in MODULES.keys():
		var config_property = MODULES[module_name].config_property
		core_config.set(config_property, true)
	print("CoreConfig.tres criado com estado padrão.")

func _populate_plugins_tab():
	for child in plugins_tab.get_children():
		if child is CheckBox:
			var module_name = child.text
			if MODULES.has(module_name):
				var config_property = MODULES[module_name].config_property
				child.button_pressed = core_config.get(config_property)

func _on_plugin_toggled(module_name: String, button_pressed: bool):
	if MODULES.has(module_name):
		var config_property = MODULES[module_name].config_property
		core_config.set(config_property, button_pressed)
		_update_autoloads_and_panels()
	else:
		push_error("Módulo desconhecido: " + module_name)

func _update_autoloads_and_panels():
	if not Engine.is_editor_hint() or not plugin_ref or not core_config or not cafe_panel_ref:
		return

	for autoload_name in MODULES.keys():
		var module_data = MODULES[autoload_name]
		var is_enabled = core_config.get(module_data.config_property)
		var has_autoload = ProjectSettings.has_setting("autoload/" + autoload_name)
		var panel_is_instantiated = instantiated_panels.has(autoload_name)

		# Manage Autoload
		if is_enabled and not has_autoload:
			plugin_ref.add_autoload_singleton(autoload_name, module_data.path)
			print("CorePanel: Autoload '%s' added." % autoload_name)
		elif not is_enabled and has_autoload:
			plugin_ref.remove_autoload_singleton(autoload_name)
			print("CorePanel: Autoload '%s' removed." % autoload_name)
		
		# Manage Panel
		if is_enabled and not panel_is_instantiated:
			var panel_scene = load(module_data.panel_path)
			if panel_scene is PackedScene:
				var new_panel = panel_scene.instantiate()
				new_panel.name = autoload_name
				instantiated_panels[autoload_name] = new_panel
				cafe_panel_ref.add_child(new_panel)
				print("CorePanel: Panel '%s' added." % autoload_name)
		elif not is_enabled and panel_is_instantiated:
			var panel_to_remove = instantiated_panels[autoload_name]
			panel_to_remove.free()
			instantiated_panels.erase(autoload_name)
			print("CorePanel: Panel '%s' removed." % autoload_name)

#<-- CONNECTION FUNCTIONS -->
func _on_data_store_check_box_toggled(toggled_on: bool): _on_plugin_toggled("DataStore", toggled_on)
func _on_save_system_check_box_toggled(toggled_on: bool): _on_plugin_toggled("SaveSystem", toggled_on)
func _on_console_debug_check_box_toggled(toggled_on: bool): _on_plugin_toggled("ConsoleDebug", toggled_on)
func _on_tests_runner_check_box_toggled(toggled_on: bool): _on_plugin_toggled("TestsRunner", toggled_on)
func _on_mobile_input_check_box_toggled(toggled_on: bool): _on_plugin_toggled("MobileInput", toggled_on)
func _on_dialogue_flow_check_box_toggled(toggled_on: bool): _on_plugin_toggled("DialogueFlow", toggled_on)
func _on_camera_control_check_box_toggled(toggled_on: bool): _on_plugin_toggled("CameraControl", toggled_on)
func _on_display_ui_check_box_toggled(toggled_on: bool): _on_plugin_toggled("DisplayUI", toggled_on)
func _on_game_settings_check_box_toggled(toggled_on: bool): _on_plugin_toggled("GameSettings", toggled_on)
func _on_scene_transition_check_box_toggled(toggled_on: bool): _on_plugin_toggled("SceneTransition", toggled_on)
func _on_pool_object_check_box_toggled(toggled_on: bool): _on_plugin_toggled("PoolObject", toggled_on)
func _on_event_control_check_box_toggled(toggled_on: bool): _on_plugin_toggled("EventControl", toggled_on)
