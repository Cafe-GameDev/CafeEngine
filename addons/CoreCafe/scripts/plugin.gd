@tool
extends EditorPlugin

const PANEL_SCENE_PATH = "res://addons/CoreCafe/scenes/cafe_panel.tscn"
const GROUP_SCENE_PATH = "res://addons/CoreCafe/scenes/core_panel.tscn"

const MODULES = {
	"DataStore": {"path": "res://addons/CoreCafe/autoloads/data/data_store.gd"},
	"SaveSystem": {"path": "res://addons/CoreCafe/autoloads/save/save_system.gd"},
	"ConsoleDebug": {"path": "res://addons/CoreCafe/autoloads/console/console_debug.gd"},
	"TestsRunner": {"path": "res://addons/CoreCafe/autoloads/tests/tests_runner.gd"},
	"MobileInput": {"path": "res://addons/CoreCafe/autoloads/mobile/mobile_input.gd"},
	"DialogueFlow": {"path": "res://addons/CoreCafe/autoloads/dialogue/dialogue_flow.gd"},
	"CameraControl": {"path": "res://addons/CoreCafe/autoloads/camera/camera_control.gd"},
	"DisplayUI": {"path": "res://addons/CoreCafe/autoloads/display/display_ui.gd"},
	"GameSettings": {"path": "res://addons/CoreCafe/autoloads/settings/gamesettings.gd"},
	"SceneTransition": {"path": "res://addons/CoreCafe/autoloads/transition/scene_transition.gd"},
	"PoolObject": {"path": "res://addons/CoreCafe/autoloads/pool/pool_object.gd"},
	"EventControl": {"path": "res://addons/CoreCafe/autoloads/event/event_control.gd"},
}

var plugin_panel: ScrollContainer

func _enter_tree():
	_create_plugin_panel()
	var core_group = _ensure_group("CoreCafe")
	
	if core_group:
		if core_group.has_method("set_plugin_reference"):
			core_group.set_plugin_reference(self)
		
		var content_container = plugin_panel.get_node_or_null("VBoxContainer")
		if content_container and core_group.has_method("set_cafe_panel_reference"):
			core_group.set_cafe_panel_reference(content_container)
	
		if core_group.has_method("_update_autoloads_and_panels"):
			core_group._update_autoloads_and_panels()

func _exit_tree():
	# 1. Remove all CoreCafe Autoloads
	for autoload_name in MODULES.keys():
		if ProjectSettings.has_setting("autoload/" + autoload_name):
			remove_autoload_singleton(autoload_name)
			print("CoreCafe Plugin: Autoload '%s' removed on exit." % autoload_name)

	if not plugin_panel:
		return

	var content_container = plugin_panel.get_node_or_null("VBoxContainer")
	if not content_container:
		return

	# 2. Remove all CoreCafe-related panels
	var panels_to_remove = []
	for child in content_container.get_children():
		if child.name == "CoreCafe" or MODULES.has(child.name):
			panels_to_remove.append(child)
	
	for panel in panels_to_remove:
		panel.free()

	# 3. If the container is now empty, remove the main CafePanel dock
	if content_container.get_child_count() == 0:
		if plugin_panel.get_parent() != null:
			remove_control_from_docks(plugin_panel)
		plugin_panel.free()
		plugin_panel = null

func _create_plugin_panel():
	plugin_panel = get_editor_interface().get_base_control().find_child("CafeEngine", true, false)
	if plugin_panel:
		return

	var panel_scene := load(PANEL_SCENE_PATH)
	if panel_scene is PackedScene:
		plugin_panel = panel_scene.instantiate()
		plugin_panel.name = "CafeEngine"
		add_control_to_dock(DOCK_SLOT_RIGHT_UL, plugin_panel)

func _ensure_group(group_name: String) -> VBoxContainer:
	if not plugin_panel:
		return null
	
	var content_container = plugin_panel.get_node_or_null("VBoxContainer")
	if not content_container:
		push_error("CafePanel is missing its VBoxContainer child!")
		return null
	
	var group = content_container.find_child(group_name, false)
	if group:
		return group

	var group_scene = load(GROUP_SCENE_PATH)
	if group_scene is PackedScene:
		group = group_scene.instantiate()
		group.name = group_name
		content_container.add_child(group)
		return group
	
	return null