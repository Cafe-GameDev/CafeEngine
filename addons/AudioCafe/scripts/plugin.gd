@tool
extends EditorPlugin

const AUTOLOAD_NAME = "CafeAudioManager"
const AUTOLOAD_PATH = "res://addons/AudioCafe/scenes/cafe_audio_manager.tscn"
const PANEL_SCENE_PATH = "res://addons/AudioCafe/scenes/cafe_panel.tscn"

var generate_manifest_script_instance: EditorScript
var plugin_panel: VBoxContainer

func _enter_tree():
	# Adiciona autoload
	if not ProjectSettings.has_setting("autoload/" + AUTOLOAD_NAME):
		add_autoload_singleton(AUTOLOAD_NAME, AUTOLOAD_PATH)
		print("CafeAudioManager Plugin: Autoload '%s' added." % AUTOLOAD_NAME)

	# Carrega script do manifest
	var manifest_script_res = load("res://addons/AudioCafe/scripts/generate_audio_manifest.gd")
	if manifest_script_res:
		generate_manifest_script_instance = manifest_script_res.new()
	else:
		push_error("generate_audio_manifest.gd script not found!")
		return

	# Cria painel, evitando duplicatas
	_create_plugin_panel()

	# Registra tipos customizados
	_register_custom_types()

	# Configura grupos globais
	ProjectSettings.set_setting("global_groups/audio_positions", true)
	ProjectSettings.set_setting("global_groups/audio_regions", true)
	ProjectSettings.set_setting("global_groups/audio_occluders", true)
	ProjectSettings.save()


func _exit_tree():
	# Remove painel
	if plugin_panel:
		remove_control_from_docks(plugin_panel)
		plugin_panel.queue_free()

	# Remove autoload
	if ProjectSettings.has_setting("autoload/" + AUTOLOAD_NAME):
		remove_autoload_singleton(AUTOLOAD_NAME)

	# Desregistra tipos
	_unregister_custom_types()

	# Remove grupos globais
	ProjectSettings.set_setting("global_groups/audio_positions", false)
	ProjectSettings.set_setting("global_groups/audio_regions", false)
	ProjectSettings.set_setting("global_groups/audio_occluders", false)
	ProjectSettings.save()


func _create_plugin_panel():
	# Verifica se já existe um painel com esse nome
	for dock in get_editor_interface().get_base_control().get_children():
		if dock.name == "CafePanel":
			plugin_panel = dock
			return

	# Instancia a cena do painel
	var panel_scene = load(PANEL_SCENE_PATH)
	if panel_scene:
		plugin_panel = panel_scene.instantiate()
	else:
		plugin_panel = VBoxContainer.new()
		plugin_panel.name = "CafePanel"

	# Adiciona botão de gerar manifest
	var btn = Button.new()
	btn.text = "Generate Audio Manifest"
	btn.icon = get_editor_interface().get_base_control().get_theme_icon("Reload", "EditorIcons")
	btn.tooltip_text = "Generates the AudioManifest.tres file."
	btn.pressed.connect(_on_generate_manifest_button_pressed)
	plugin_panel.add_child(btn)

	add_control_to_dock(DOCK_SLOT_RIGHT_UL, plugin_panel)


func _on_generate_manifest_button_pressed():
	if generate_manifest_script_instance:
		generate_manifest_script_instance._run()
	else:
		push_error("generate_audio_manifest.gd script instance not available!")


# -------------------------------
# Custom types
# -------------------------------
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
