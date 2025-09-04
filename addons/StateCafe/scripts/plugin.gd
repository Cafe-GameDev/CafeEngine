@tool
extends EditorPlugin

const AUTOLOAD_NAME = "StateCafe"
const AUTOLOAD_PATH = "res://addons/StateCafe/scripts/state_cafe.gd"
const PANEL_SCENE_PATH = "res://addons/StateCafe/scenes/cafe_panel.tscn"
const GROUP_SCENE_PATH = "res://addons/StateCafe/scenes/state_panel.tscn"
var plugin_panel: ScrollContainer

func _enter_tree():
	# Adiciona autoload
	if not ProjectSettings.has_setting("autoload/" + AUTOLOAD_NAME):
		add_autoload_singleton(AUTOLOAD_NAME, AUTOLOAD_PATH)
		print("StateCafe Plugin: Autoload '%s' added." % AUTOLOAD_NAME)
	
	# Cria painel e garante o grupo deste plugin
	_create_plugin_panel()
	_register_custom_types()


func _exit_tree():
	# Garante que a referência ao painel não foi perdida
	if not plugin_panel:
		plugin_panel = get_editor_interface().get_base_control().find_child("CafeEngine", true, false)

	if plugin_panel:
		var content_container = plugin_panel.get_node_or_null("VBoxContainer")
		if content_container:
			# Remove o grupo deste plugin
			var group = content_container.find_child(AUTOLOAD_NAME, false)
			if group:
				group.free()
			
			# Se o container ficar vazio, remove o painel principal
			if content_container.get_child_count() == 0:
				remove_control_from_docks(plugin_panel)
				plugin_panel.free()
				plugin_panel = null

	# Remove autoload
	if ProjectSettings.has_setting("autoload/" + AUTOLOAD_NAME):
		remove_autoload_singleton(AUTOLOAD_NAME)

	# Desregistra tipos customizados
	_unregister_custom_types()


func _create_plugin_panel():
	# Procura por um painel existente
	plugin_panel = get_editor_interface().get_base_control().find_child("CafeEngine", true, false)
	if plugin_panel:
		print("Painel 'CafeEngine' já existente, reaproveitando.")
		_ensure_group(AUTOLOAD_NAME) # Garante que o grupo seja criado se não existir
		return

	# Se não existir, cria um novo
	var panel_scene := load(PANEL_SCENE_PATH)
	if panel_scene is PackedScene:
		plugin_panel = panel_scene.instantiate()
		plugin_panel.name = "CafeEngine"
		add_control_to_dock(DOCK_SLOT_RIGHT_UL, plugin_panel)
		print("Painel 'CafeEngine' criado.")
		_ensure_group(AUTOLOAD_NAME) # Cria o grupo no painel novo
	else:
		push_error("Não foi possível carregar a cena do painel principal do CafeEngine.")


func _ensure_group(group_name: String) -> VBoxContainer:
	if not plugin_panel:
		push_error("Referência ao painel principal 'CafeEngine' não encontrada.")
		return null

	var content_container = plugin_panel.get_node_or_null("VBoxContainer")
	if not content_container:
		push_error("O painel 'CafeEngine' não contém o 'VBoxContainer' esperado.")
		return null

	# Procura pelo grupo existente
	var group = content_container.find_child(group_name, false)
	if group:
		return group

	# Se não existir, cria um novo
	var group_scene = load(GROUP_SCENE_PATH)
	if group_scene and group_scene is PackedScene:
		group = group_scene.instantiate()
		group.name = group_name
		content_container.add_child(group)
		return group
	
	push_error("Não foi possível carregar a cena do grupo: " + group_name)
	return null



func _register_custom_types():
	pass

func _unregister_custom_types():
	pass
