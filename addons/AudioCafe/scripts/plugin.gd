@tool
extends EditorPlugin

const AUTOLOAD_NAME = "CafeAudioManager"
const AUTOLOAD_PATH = "res://addons/AudioCafe/scenes/cafe_audio_manager.tscn"
const PANEL_SCENE_PATH = "res://addons/AudioCafe/scenes/cafe_panel.tscn"
const GROUP_SCENE_PATH = "res://addons/AudioCafe/scenes/panel_group.tscn"

var generate_manifest_script_instance: EditorScript
var plugin_panel: VBoxContainer

func _enter_tree():
	# Adiciona autoload
	if not ProjectSettings.has_setting("autoload/" + AUTOLOAD_NAME):
		add_autoload_singleton(AUTOLOAD_NAME, AUTOLOAD_PATH)
		print("CafeAudioManager Plugin: Autoload '%s' added." % AUTOLOAD_NAME)

	# Carrega script do manifest
	generate_manifest_script_instance = EditorScript.new()
	generate_manifest_script_instance.set_script(load("res://addons/AudioCafe/scripts/generate_audio_manifest.gd"))
	

	# Cria painel, evitando duplicatas
	_create_plugin_panel()
	
	# Registra tipos customizados
	_register_custom_types()


func _exit_tree():
	if plugin_panel:
		# Remove o grupo deste plugin
		var group : VBoxContainer = plugin_panel.get_node_or_null(AUTOLOAD_NAME)
		if group:
			group.queue_free()
	
		# Verifica se o painel ainda tem outros grupos
		var has_other_groups : bool = false
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
	
	
	var group : VBoxContainer =_ensure_group("AudioCafe")
	
	

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
			# Se o grupo já existe, e ele tem a propriedade 'editor_interface', define-a
			if child.has_method("set_editor_interface"):
				child.set_editor_interface(get_editor_interface())
			return child

	# Tenta carregar o grupo de uma cena
	var group_scene = load(GROUP_SCENE_PATH)
	var group : VBoxContainer
	if group_scene and group_scene is PackedScene:
		group = group_scene.instantiate()
	else:
		group = VBoxContainer.new()  # fallback caso a cena não exista

	group.name = group_name
	
	# Passa a referência do EditorInterface para o grupo
	if group.has_method("set_editor_interface"):
		group.set_editor_interface(get_editor_interface())

	# Carrega o AudioConfig.tres e passa para o grupo
	var audio_config_res = load("res://addons/AudioCafe/resources/audio_config.tres")
	if audio_config_res and group.has_method("set_audio_config"):
		group.set_audio_config(audio_config_res)
	else:
		push_error("AudioConfig.tres não encontrado ou set_audio_config não disponível no grupo!")

	# Atualiza o Label interno, caso exista
	var label = group.get_node_or_null("Label")
	if label and label is Label:
		label.text = group_name

	plugin_panel.add_child(group)
	return group


func _register_custom_types():
	add_custom_type("AudioCafe", "Node", preload("res://addons/AudioCafe/scripts/audiocafe.gd"), null)
	add_custom_type("SFXAcceptDialog", "AudioCafe", preload("res://addons/AudioCafe/components/Control/sfx_accept_dialog.gd"), null)
	add_custom_type("SFXButton", "AudioCafe", preload("res://addons/AudioCafe/components/Control/sfx_button.gd"), null)
	add_custom_type("SFXCheckButton", "AudioCafe", preload("res://addons/AudioCafe/components/Control/sfx_check_button.gd"), null)
	add_custom_type("SFXColorPickerButton", "AudioCafe", preload("res://addons/AudioCafe/components/Control/sfx_color_picker_button.gd"), null)
	add_custom_type("SFXColorPicker", "AudioCafe", preload("res://addons/AudioCafe/components/Control/sfx_color_picker.gd"), null)
	add_custom_type("SFXConfirmationDialog", "AudioCafe", preload("res://addons/AudioCafe/components/Control/sfx_confirmation_dialog.gd"), null)
	add_custom_type("SFXFileDialog", "AudioCafe", preload("res://addons/AudioCafe/components/Control/sfx_file_dialog.gd"), null)
	add_custom_type("SFXItemList", "AudioCafe", preload("res://addons/AudioCafe/components/Control/sfx_item_list.gd"), null)
	add_custom_type("SFXLineEdit", "AudioCafe", preload("res://addons/AudioCafe/components/Control/sfx_line_edit.gd"), null)
	add_custom_type("SFXLinkButton", "AudioCafe", preload("res://addons/AudioCafe/components/Control/sfx_link_button.gd"), null)
	add_custom_type("SFXMenuButton", "AudioCafe", preload("res://addons/AudioCafe/components/Control/sfx_menu_button.gd"), null)
	add_custom_type("SFXOptionButton", "AudioCafe", preload("res://addons/AudioCafe/components/Control/sfx_option_button.gd"), null)
	add_custom_type("SFXPopupMenu", "AudioCafe", preload("res://addons/AudioCafe/components/Control/sfx_popup_menu.gd"), null)
	add_custom_type("SFXProgressBar", "AudioCafe", preload("res://addons/AudioCafe/components/Control/sfx_progress_bar.gd"), null)
	add_custom_type("SFXScrollContainer", "AudioCafe", preload("res://addons/AudioCafe/components/Control/sfx_scroll_container.gd"), null)
	add_custom_type("SFXSlider", "AudioCafe", preload("res://addons/AudioCafe/components/Control/sfx_slider.gd"), null)
	add_custom_type("SFXSpinBox", "AudioCafe", preload("res://addons/AudioCafe/components/Control/sfx_spin_box.gd"), null)
	add_custom_type("SFXTabContainer", "AudioCafe", preload("res://addons/AudioCafe/components/Control/sfx_tab_container.gd"), null)
	add_custom_type("SFXTextEdit", "TextAudioCafeEdit", preload("res://addons/AudioCafe/components/Control/sfx_text_edit.gd"), null)
	add_custom_type("SFXTextureProgressBar", "AudioCafe", preload("res://addons/AudioCafe/components/Control/sfx_texture_progress_bar.gd"), null)
	add_custom_type("SFXTree", "AudioCafe", preload("res://addons/AudioCafe/components/Control/sfx_tree.gd"), null)
	add_custom_type("SFXVolumeSlider", "AudioCafe", preload("res://addons/AudioCafe/components/Control/sfx_volume_slider.gd"), null)
	add_custom_type("SFXWindow", "AudioCafe", preload("res://addons/AudioCafe/components/Control/sfx_window.gd"), null)


func _unregister_custom_types():
	remove_custom_type("AudioCafe")
	remove_custom_type("SFXAcceptDialog")
	remove_custom_type("SFXButton")
	remove_custom_type("SFXCheckButton")
	remove_custom_type("SFXColorPickerButton")
	remove_custom_type("SFXColorPicker")
	remove_custom_type("SFXConfirmationDialog")
	remove_custom_type("SFXFileDialog")
	remove_custom_type("SFXItemList")
	remove_custom_type("SFXLineEdit")
	remove_custom_type("SFXLinkButton")
	remove_custom_type("SFXMenuButton")
	remove_custom_type("SFXOptionButton")
	remove_custom_type("SFXPopupMenu")
	remove_custom_type("SFXProgressBar")
	remove_custom_type("SFXScrollContainer")
	remove_custom_type("SFXSlider")
	remove_custom_type("SFXSpinBox")
	remove_custom_type("SFXTabContainer")
	remove_custom_type("SFXTextEdit")
	remove_custom_type("SFXTextureProgressBar")
	remove_custom_type("SFXTree")
	remove_custom_type("SFXVolumeSlider")
	remove_custom_type("SFXWindow")
