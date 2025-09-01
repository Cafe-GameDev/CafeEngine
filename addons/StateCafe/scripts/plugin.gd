@tool
extends EditorPlugin

const AUTOLOAD_NAME = "StateCafe"
const AUTOLOAD_PATH = "res://addons/StateCafe/scripts/state_cafe.gd"
const PANEL_SCENE_PATH = "res://addons/StateCafe/scenes/cafe_panel.tscn"
const GROUP_SCENE_PATH = "res://addons/StateCafe/scenes/panel_group.tscn"
var plugin_panel: VBoxContainer

func _enter_tree():
	# Adiciona autoload
	if not ProjectSettings.has_setting("autoload/" + AUTOLOAD_NAME):
		add_autoload_singleton(AUTOLOAD_NAME, AUTOLOAD_PATH)
		print("StateCafe Plugin: Autoload '%s' added." % AUTOLOAD_NAME)
	
	# Cria painel e garante o grupo deste plugin
	_create_plugin_panel()
	_ensure_group("StateCafe")
	_register_custom_types()


func _exit_tree():
	if plugin_panel:
		# Remove o grupo deste plugin
		var group : VBoxContainer = plugin_panel.get_node_or_null(AUTOLOAD_NAME)
		if group:
			group.queue_free()
	
		# Verifica se o painel ainda tem outros grupos
		var has_other_groups := false
		for child in plugin_panel.get_children():
			if child is VBoxContainer:
				has_other_groups = true
				break

		# Se não houver mais grupos, remove o painel do dock
		if not has_other_groups:
			remove_control_from_docks(plugin_panel)
			plugin_panel.queue_free()
			plugin_panel = null

	# Remove autoload
	if ProjectSettings.has_setting("autoload/" + AUTOLOAD_NAME):
		remove_autoload_singleton(AUTOLOAD_NAME)

	# Desregistra tipos customizados
	_unregister_custom_types()


func _create_plugin_panel():
	var existing_panel := _find_cafe_panel()
	
	if existing_panel:
		plugin_panel = existing_panel
		print("Painel 'Cafe' já existente, reaproveitando.")
	else:
		# Tenta carregar a cena do painel
		var panel_scene := load(PANEL_SCENE_PATH)
		if panel_scene is PackedScene:
			plugin_panel = panel_scene.instantiate()
		else:
			plugin_panel = VBoxContainer.new()
		
		plugin_panel.name = "Cafe"
		add_control_to_dock(DOCK_SLOT_RIGHT_UL, plugin_panel)
		print("Painel 'Cafe' criado.")


# Busca painel "Cafe" em todos os docks
func _find_cafe_panel() -> VBoxContainer:
	var root: Control = get_editor_interface().get_base_control()
	if not root:
		return null
	return _dfs_find_cafe(root)


func _dfs_find_cafe(node: Node) -> VBoxContainer:
	for child in node.get_children():
		if child is VBoxContainer and child.name == "Cafe":
			return child
		var found := _dfs_find_cafe(child)
		if found:
			return found
	return null


# Cria ou retorna o grupo deste plugin dentro do painel
func _ensure_group(group_name: String) -> VBoxContainer:
	# Se já existe, retorna
	for child in plugin_panel.get_children():
		if child is VBoxContainer and child.name == group_name:
			return child
	
	# Tenta carregar o grupo de uma cena
	var group_scene = load(GROUP_SCENE_PATH)
	var group : VBoxContainer
	if group_scene and group_scene is PackedScene:
		group = group_scene.instantiate()
	else:
		group = VBoxContainer.new()  # fallback caso a cena não exista
	
	group.name = group_name
	
	# Atualiza o Label interno, caso exista
	var label = group.get_node_or_null("Label")
	if label and label is Label:
		label.text = group_name
	
	plugin_panel.add_child(group)
	return group



func _register_custom_types():
	pass

func _unregister_custom_types():
	pass
