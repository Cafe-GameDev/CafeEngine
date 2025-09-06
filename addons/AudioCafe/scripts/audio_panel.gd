@tool
extends VBoxContainer
@onready var audio_manifest: Button = $AudioManifest

@onready var tab_container: TabContainer = $TabContainer

@onready var sfx_paths_grid_container: GridContainer = tab_container.get_node("Paths/SFXPathsSection/SFXPathsGridContainer")
@onready var add_sfx_path_button: Button = tab_container.get_node("Paths/SFXPathsSection/AddSFXPathButton")
@onready var sfx_folder_dialog: FileDialog = $SFXFolderDialog

@onready var music_paths_grid_container: GridContainer = tab_container.get_node("Paths/MusicPathsSection/MusicPathsGridContainer")
@onready var add_music_path_button: Button = tab_container.get_node("Paths/MusicPathsSection/AddMusicPathButton")
@onready var music_folder_dialog: FileDialog = $MusicFolderDialog

@onready var default_click_key_line_edit: LineEdit = $TabContainer/DefaultKeys/DefaultKeyGridContainer/DefaultClickKeyLineEdit
@onready var default_slider_key_line_edit: LineEdit = $TabContainer/DefaultKeys/DefaultKeyGridContainer/DefaultSliderKeyLineEdit
@onready var default_hover_key_line_edit: LineEdit = $TabContainer/DefaultKeys/DefaultKeyGridContainer/DefaultHoverKeyLineEdit

@onready var save_feedback_label: Label = $SaveFeedbackLabel
@onready var save_feedback_timer: Timer = $SaveFeedbackTimer

@onready var master_volume_slider: HSlider = tab_container.get_node("DefaultKeys/VolumeGridContainer/MasterVolumeSlider")
@onready var master_volume_value_label: Label = tab_container.get_node("DefaultKeys/VolumeGridContainer/MasterVolumeValueLabel")
@onready var sfx_volume_slider: HSlider = tab_container.get_node("DefaultKeys/VolumeGridContainer/SFXVolumeSlider")
@onready var sfx_volume_value_label: Label = tab_container.get_node("DefaultKeys/VolumeGridContainer/SFXVolumeValueLabel")
@onready var music_volume_slider: HSlider = tab_container.get_node("DefaultKeys/VolumeGridContainer/MusicVolumeSlider")
@onready var music_volume_value_label: Label = tab_container.get_node("DefaultKeys/VolumeGridContainer/MusicVolumeValueLabel")

@onready var music_keys_rich_text_label: RichTextLabel = tab_container.get_node("AvailableMusic/MusicKeysRichTextLabel")
@onready var sfx_keys_rich_text_label: RichTextLabel = tab_container.get_node("AvailableSFX/SFXKeysRichTextLabel")

@onready var manifest_progress_bar: ProgressBar = $ManifestProgressBar
@onready var manifest_status_label: Label = $ManifestStatusLabel

@export var audio_config: AudioConfig = preload("res://addons/AudioCafe/resources/audio_config.tres")

var generate_manifest_script_instance: EditorScript
var editor_interface: EditorInterface

const MANIFEST_SAVE_PATH = "res://addons/AudioCafe/resources/audio_manifest.tres"
const VALID_COLOR = Color(1.0, 1.0, 1.0, 1.0) # Cor de borda padrão (Branco)
const INVALID_COLOR = Color(1.0, 0.2, 0.2, 1.0) # Cor de borda para erro

func set_editor_interface(interface: EditorInterface):
	editor_interface = interface

func set_audio_config(config: AudioConfig):
	if audio_config and audio_config.is_connected("config_changed", Callable(self, "_show_save_feedback")):
		audio_config.disconnect("config_changed", Callable(self, "_show_save_feedback"))
	audio_config = config
	if audio_config:
		audio_config.connect("config_changed", Callable(self, "_show_save_feedback"))
	_load_config_to_ui() # Recarrega a UI com a nova configuração

func _show_save_feedback():
	save_feedback_label.visible = true
	save_feedback_timer.start()

func _ready():
	print("[_ready] tab_container: ", tab_container)
	# Conecta ao sinal de atualização do AudioConfig do CafeAudioManager
	if CafeAudioManager: # Verifica se o autoload está disponível
		CafeAudioManager.audio_config_updated.connect(Callable(self, "_on_audio_config_updated"))

	var manifest_script_res = load("res://addons/AudioCafe/scripts/generate_audio_manifest.gd")
	if manifest_script_res:
		generate_manifest_script_instance = manifest_script_res.new()
	else:
		push_error("generate_audio_manifest.gd script not found!")
		return
	
	if Engine.is_editor_hint() and editor_interface:
		audio_manifest.icon = editor_interface.get_base_control().get_theme_icon("Reload", "EditorIcons")
	
	if Engine.is_editor_hint():
		_load_config_to_ui()
		_connect_ui_signals()
		add_sfx_path_button.pressed.connect(Callable(self, "_on_add_sfx_path_button_pressed"))
		add_music_path_button.pressed.connect(Callable(self, "_on_add_music_path_button_pressed"))
		sfx_folder_dialog.dir_selected.connect(Callable(self, "_on_sfx_folder_dialog_dir_selected"))
		music_folder_dialog.dir_selected.connect(Callable(self, "_on_music_folder_dialog_dir_selected"))

func _load_config_to_ui():
	if not tab_container: return # Garante que o tab_container esteja pronto
	if audio_config:
		print("--- Loading config to UI ---")
		print("SFX paths in resource: ", audio_config.sfx_paths)
		# Limpa as entradas de caminho existentes
		if sfx_paths_grid_container:
			for child in sfx_paths_grid_container.get_children():
				child.queue_free()
			var sfx_count = 0
			for path in audio_config.sfx_paths:
				sfx_count += 1
				_create_path_entry(path, true)
			print("Created ", sfx_count, " SFX path UI entries.")

		print("Music paths in resource: ", audio_config.music_paths)
		if music_paths_grid_container:
			for child in music_paths_grid_container.get_children():
				child.queue_free()
			var music_count = 0
			for path in audio_config.music_paths:
				music_count += 1
				_create_path_entry(path, false)
			print("Created ", music_count, " Music path UI entries.")
		print("--- Finished loading config to UI ---")

		print("[_load_config_to_ui] default_click_key_line_edit: ", default_click_key_line_edit)
		print("[_load_config_to_ui] default_hover_key_line_edit: ", default_hover_key_line_edit)
		print("[_load_config_to_ui] default_slider_key_line_edit: ", default_slider_key_line_edit)

		if default_click_key_line_edit: default_click_key_line_edit.text = audio_config.default_click_key
		if default_hover_key_line_edit: default_hover_key_line_edit.text = audio_config.default_hover_key
		if default_slider_key_line_edit: default_slider_key_line_edit.text = audio_config.default_slider_key

		if master_volume_slider: master_volume_slider.value = audio_config.master_volume
		if master_volume_value_label: _update_volume_label(master_volume_value_label, audio_config.master_volume)
		if sfx_volume_slider: sfx_volume_slider.value = audio_config.sfx_volume
		if sfx_volume_value_label: _update_volume_label(sfx_volume_value_label, audio_config.sfx_volume)
		if music_volume_slider: music_volume_slider.value = audio_config.music_volume
		if music_volume_value_label: _update_volume_label(music_volume_value_label, audio_config.music_volume)

		# Preenche os ItemList com as chaves de música e SFX
		var current_music_keys_rich_text_label = tab_container.get_node("AvailableMusic/MusicKeysRichTextLabel")
		var current_sfx_keys_rich_text_label = tab_container.get_node("AvailableSFX/SFXKeysRichTextLabel")

		if current_music_keys_rich_text_label: current_music_keys_rich_text_label.clear()
		if current_sfx_keys_rich_text_label: current_sfx_keys_rich_text_label.clear()

		# Carrega o AudioManifest para obter as chaves de áudio
		var loaded_manifest = ResourceLoader.load(MANIFEST_SAVE_PATH, "", ResourceLoader.CacheMode.CACHE_MODE_REPLACE)
		if loaded_manifest and loaded_manifest is AudioManifest:
			print("DEBUG: _load_config_to_ui - music_data keys from manifest: ", loaded_manifest.music_data.keys())
			if current_music_keys_rich_text_label:
				var music_keys = loaded_manifest.music_data.keys()
				music_keys.sort()
				for key in music_keys:
					current_music_keys_rich_text_label.append_text(key + "\n")
			else:
				push_error("current_music_keys_rich_text_label is null when trying to add item.")

			print("DEBUG: _load_config_to_ui - sfx_data keys from manifest: ", loaded_manifest.sfx_data.keys())
			if current_sfx_keys_rich_text_label:
				var sfx_keys = loaded_manifest.sfx_data.keys()
				sfx_keys.sort()
				for key in sfx_keys:
					current_sfx_keys_rich_text_label.append_text(key + "\n")
			else:
				push_error("current_sfx_keys_rich_text_label is null when trying to add item.")
		else:
			push_error("Falha ao carregar AudioManifest.tres em _load_config_to_ui.")


func _connect_ui_signals():
	default_click_key_line_edit.text_changed.connect(func(new_text): _on_config_text_changed(new_text, "default_click_key"))
	default_hover_key_line_edit.text_changed.connect(func(new_text): _on_config_text_changed(new_text, "default_hover_key"))
	default_slider_key_line_edit.text_changed.connect(func(new_text): _on_config_text_changed(new_text, "default_slider_key"))

	master_volume_slider.value_changed.connect(func(new_value): _on_volume_slider_value_changed(new_value, "Master", master_volume_value_label, "master_volume"))
	sfx_volume_slider.value_changed.connect(func(new_value): _on_volume_slider_value_changed(new_value, "SFX", sfx_volume_value_label, "sfx_volume"))
	music_volume_slider.value_changed.connect(func(new_value): _on_volume_slider_value_changed(new_value, "Music", music_volume_value_label, "music_volume"))

func _on_config_text_changed(new_text: String, config_property: String):
	if audio_config:
		var line_edit: LineEdit = get_node_or_null("%" + config_property.capitalize() + "LineEdit") # Obtém a referência ao LineEdit
		var is_valid = true
		var error_message = ""

		if new_text.is_empty():
			is_valid = false
			error_message = "Key cannot be empty."

		if is_valid:
			if line_edit:
				line_edit.add_theme_color_override("font_color", VALID_COLOR)
				line_edit.tooltip_text = ""
			audio_config.set(config_property, new_text)
			print("Configuration updated: %s = %s" % [config_property, new_text])
		else:
			if line_edit:
				line_edit.add_theme_color_override("font_color", INVALID_COLOR)
				line_edit.tooltip_text = error_message

func _on_volume_slider_value_changed(new_value: float, bus_name: String, value_label: Label, config_property: String):
	if audio_config:
		audio_config.set(config_property, new_value)
		_update_volume_label(value_label, new_value)
		CafeAudioManager.apply_volume_to_bus(bus_name, new_value)
		print("Volume atualizado para %s: %s" % [bus_name, new_value])

func _update_volume_label(label: Label, volume_value: float):
	label.text = str(int(volume_value * 100)) + "%"

func _create_path_entry(path_value: String, is_sfx: bool):
	var path_entry = HBoxContainer.new()
	path_entry.size_flags_horizontal = SIZE_EXPAND_FILL

	var line_edit = LineEdit.new()
	line_edit.size_flags_horizontal = SIZE_EXPAND_FILL
	line_edit.text = path_value
	line_edit.placeholder_text = "res://path/to/folder"
	line_edit.text_changed.connect(Callable(self, "_on_path_line_edit_text_changed").bind(line_edit, is_sfx))
	path_entry.add_child(line_edit)

	# Define a cor da borda inicial e valida
	_validate_path_line_edit(line_edit)

	var browse_button = Button.new()
	browse_button.text = "..."
	browse_button.pressed.connect(Callable(self, "_on_browse_button_pressed").bind(line_edit, is_sfx))
	path_entry.add_child(browse_button)

	var remove_button = Button.new()
	remove_button.text = "X"
	remove_button.pressed.connect(Callable(self, "_on_remove_path_button_pressed").bind(path_entry, is_sfx))
	path_entry.add_child(remove_button)

	print("[_create_path_entry] sfx_paths_grid_container: ", sfx_paths_grid_container)
	print("[_create_path_entry] music_paths_grid_container: ", music_paths_grid_container)

	if is_sfx:
		sfx_paths_grid_container.add_child(path_entry) # Line 219
	else:
		music_paths_grid_container.add_child(path_entry) # Line 221

func _on_browse_button_pressed(line_edit: LineEdit, is_sfx: bool):
	if is_sfx:
		sfx_folder_dialog.current_dir = line_edit.text if not line_edit.text.is_empty() else "res://"
		sfx_folder_dialog.popup_centered()
		sfx_folder_dialog.set_meta("target_line_edit", line_edit)
	else:
		music_folder_dialog.current_dir = line_edit.text if not line_edit.text.is_empty() else "res://"
		music_folder_dialog.popup_centered()
		music_folder_dialog.set_meta("target_line_edit", line_edit)

func _on_sfx_folder_dialog_dir_selected(dir: String):
	var target_line_edit: LineEdit = sfx_folder_dialog.get_meta("target_line_edit")
	if target_line_edit:
		var localized_path = ProjectSettings.localize_path(dir)
		target_line_edit.text = localized_path
		_update_audio_config_paths()

func _on_music_folder_dialog_dir_selected(dir: String):
	var target_line_edit: LineEdit = music_folder_dialog.get_meta("target_line_edit")
	if target_line_edit:
		var localized_path = ProjectSettings.localize_path(dir)
		target_line_edit.text = localized_path
		_update_audio_config_paths()

func _on_path_line_edit_text_changed(new_text: String, line_edit: LineEdit, is_sfx: bool):
	_validate_path_line_edit(line_edit)
	_update_audio_config_paths()

func _validate_path_line_edit(line_edit: LineEdit):
	var is_valid = true
	var error_message = ""

	print("DEBUG: Validating path: ", line_edit.text)
	print("DEBUG: Begins with res://? ", line_edit.text.begins_with("res://"))

	if line_edit.text.is_empty():
		is_valid = false
		error_message = "Path cannot be empty."
	elif not line_edit.text.begins_with("res://"):
		is_valid = false
		error_message = "Path must start with 'res://'."

	if is_valid:
		line_edit.add_theme_color_override("font_color", VALID_COLOR)
		line_edit.tooltip_text = ""
	else:
		line_edit.add_theme_color_override("font_color", INVALID_COLOR)
		line_edit.tooltip_text = error_message

func _on_remove_path_button_pressed(path_entry: HBoxContainer, is_sfx: bool):
	path_entry.get_parent().remove_child(path_entry)
	_update_audio_config_paths()
	path_entry.queue_free()

func _update_audio_config_paths():
	if not audio_config:
		return

	var new_sfx_paths: Array[String] = []
	for child in sfx_paths_grid_container.get_children():
		if child is HBoxContainer:
			var line_edit: LineEdit = child.get_child(0)
			if line_edit and not line_edit.text.is_empty() and line_edit.text.begins_with("res://"):
				new_sfx_paths.append(line_edit.text)
	audio_config.sfx_paths = new_sfx_paths

	var new_music_paths: Array[String] = []
	for child in music_paths_grid_container.get_children():
		if child is HBoxContainer:
			var line_edit: LineEdit = child.get_child(0)
			if line_edit and not line_edit.text.is_empty() and line_edit.text.begins_with("res://"):
				new_music_paths.append(line_edit.text)
	audio_config.music_paths = new_music_paths

func _on_audio_manifest_pressed() -> void:
	if generate_manifest_script_instance:
		manifest_progress_bar.value = 0
		manifest_progress_bar.visible = true
		manifest_status_label.text = "Generating Manifest..."
		manifest_status_label.visible = true
		audio_manifest.disabled = true # Desabilita o botão durante a geração

		# Conecta os sinais do script de geração do manifesto
		generate_manifest_script_instance.connect("progress_updated", Callable(self, "_on_manifest_progress_updated"))
		generate_manifest_script_instance.connect("generation_finished", Callable(self, "_on_manifest_generation_finished"))

		generate_manifest_script_instance._run()
	else:
		push_error("generate_audio_manifest.gd script instance not available!")

func _on_manifest_progress_updated(current: int, total: int):
	manifest_progress_bar.max_value = total
	manifest_progress_bar.value = current
	manifest_status_label.text = "Generating Manifest... (%d/%d)" % [current, total]

func _on_manifest_generation_finished(success: bool, message: String):
	manifest_progress_bar.visible = false
	audio_manifest.disabled = false # Reabilita o botão

	if success:
		manifest_status_label.text = "Manifest Generated Successfully!"
		# Recarrega o recurso AudioConfig para garantir que ele reflita as últimas alterações
		var config_path = audio_config.resource_path if audio_config else "res://addons/AudioCafe/resources/audio_config.tres"
		var reloaded_config = ResourceLoader.load(config_path, "", ResourceLoader.CacheMode.CACHE_MODE_REPLACE) # Usar CACHE_MODE_REPLACE para recarregar sem cache
		if reloaded_config and reloaded_config is AudioConfig:
			audio_config = reloaded_config # Atribui a configuração recarregada à variável export do painel
			audio_config.emit_changed() # Notifica o editor que o AudioConfig foi modificado
			print("DEBUG: AudioConfig recarregado e atualizado com novos dados do manifesto.")
		else:
			push_error("Falha ao recarregar audio_config.tres após a geração do manifesto.")

		# Força a atualização da UI para mostrar as novas chaves
		_load_config_to_ui() # Chama _load_config_to_ui diretamente após recarregar a configuração
	else:
		manifest_status_label.text = "Manifest Generation Error: %s" % message

	# Desconecta os sinais para evitar múltiplas conexões
	if generate_manifest_script_instance.is_connected("progress_updated", Callable(self, "_on_manifest_progress_updated")):
		generate_manifest_script_instance.disconnect("progress_updated", Callable(self, "_on_manifest_progress_updated"))
	if generate_manifest_script_instance.is_connected("generation_finished", Callable(self, "_on_manifest_generation_finished")):
		generate_manifest_script_instance.disconnect("generation_finished", Callable(self, "_on_manifest_generation_finished"))

func _on_audio_config_updated(config: AudioConfig):
	# Atualiza a UI do painel quando o AudioConfig é alterado
	audio_config = config
	_load_config_to_ui()

	# Atualiza os sliders de volume e labels
	master_volume_slider.value = audio_config.master_volume
	_update_volume_label(master_volume_value_label, audio_config.master_volume)
	sfx_volume_slider.value = audio_config.sfx_volume
	_update_volume_label(sfx_volume_value_label, audio_config.sfx_volume)
	music_volume_slider.value = audio_config.music_volume
	_update_volume_label(music_volume_value_label, audio_config.music_volume)

	# Refresca os ItemList com as chaves de música e SFX
	music_keys_rich_text_label.clear()
	sfx_keys_rich_text_label.clear()

	# Carrega o AudioManifest para obter as chaves de áudio
	var loaded_manifest = ResourceLoader.load(MANIFEST_SAVE_PATH, "", ResourceLoader.CacheMode.CACHE_MODE_REPLACE)
	if loaded_manifest and loaded_manifest is AudioManifest:
		print("DEBUG: _on_audio_config_updated - music_data keys from manifest: ", loaded_manifest.music_data.keys())
		var music_keys = loaded_manifest.music_data.keys()
		music_keys.sort()
		for key in music_keys:
			music_keys_rich_text_label.append_text(key + "\n")

		print("DEBUG: _on_audio_config_updated - sfx_data keys from manifest: ", loaded_manifest.sfx_data.keys())
		var sfx_keys = loaded_manifest.sfx_data.keys()
		sfx_keys.sort()
		for key in sfx_keys:
			sfx_keys_rich_text_label.append_text(key + "\n")
	else:
		push_error("Falha ao carregar AudioManifest.tres em _on_audio_config_updated.")

func _on_save_feedback_timer_timeout():
	save_feedback_label.visible = false

func _on_add_sfx_path_button_pressed():
	_create_path_entry("", true)
	_update_audio_config_paths()

func _on_add_music_path_button_pressed() -> void:
	_create_path_entry("", false)
	_update_audio_config_paths()
