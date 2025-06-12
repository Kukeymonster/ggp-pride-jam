extends Control

var userPref: UserPreferences

@onready var MasterVolumeSlider  = $FlowContainer/VBoxContainer/MasterVolumeContainer/HBoxContainer/HSlider
@onready var MasterLineEdit = $FlowContainer/VBoxContainer/MasterVolumeContainer/HBoxContainer/LineEdit

@onready var GameVolumeSlider = $FlowContainer/VBoxContainer/GameVolumeContainer/HBoxContainer/HSlider
@onready var GameLineEdit = $FlowContainer/VBoxContainer/GameVolumeContainer/HBoxContainer/LineEdit

@onready var SfxVolumeSlider = $FlowContainer/VBoxContainer/SFXVolumeContainer/HBoxContainer/HSlider
@onready var SfxLineEdit = $FlowContainer/VBoxContainer/SFXVolumeContainer/HBoxContainer/LineEdit

@onready var VoiceVolumeSlider = $FlowContainer/VBoxContainer/VoiceVolumeContainer/HBoxContainer/HSlider
@onready var VoiceLineEdit = $FlowContainer/VBoxContainer/VoiceVolumeContainer/HBoxContainer/LineEdit

@onready var MusicVolumeSlider = $FlowContainer/VBoxContainer/MusicVolumeContainer/HBoxContainer/HSlider
@onready var MusicLineEdit = $FlowContainer/VBoxContainer/MusicVolumeContainer/HBoxContainer/LineEdit

@onready var windowModeButton = $FlowContainer/VBoxContainer/WindowModeContainer/HBoxContainer/OptionButton as OptionButton
@onready var resolutionsButton = $FlowContainer/VBoxContainer/ResolutionContainer/HBoxContainer/OptionButton as OptionButton


func _ready():
	userPref = UserPreferences.loadOrCreate()
	
	_update_ui_from_prefs()
	
	add_window_mode_items()

	add_resolution_selected()
	
	MasterVolumeSlider.value_changed.connect(_on_Master_slider_value_changed)
	MasterLineEdit.text_changed.connect(_on_Master_line_edit_text_changed)
	
	GameVolumeSlider.value_changed.connect(_on_Game_slider_value_changed)
	GameLineEdit.text_changed.connect(_on_Game_line_edit_text_changed)
	
	SfxVolumeSlider.value_changed.connect(_on_Sfx_slider_value_changed)
	SfxLineEdit.text_changed.connect(_on_Sfx_line_edit_text_changed)
	
	VoiceVolumeSlider.value_changed.connect(_on_Voice_slider_value_changed)
	VoiceLineEdit.text_changed.connect(_on_Voice_line_edit_text_changed)
	
	MusicVolumeSlider.value_changed.connect(_on_Music_slider_value_changed)
	MusicLineEdit.text_changed.connect(_on_Music_line_edit_text_changed)
	
	windowModeButton.select(userPref.windowModeIndex)
	resolutionsButton.select(userPref.resolutionIndex)

func _update_ui_from_prefs():
	MasterVolumeSlider.value = userPref.masterAudioLevel
	MasterLineEdit.text = "%.0f%%" % (userPref.masterAudioLevel * 100)

	GameVolumeSlider.value = userPref.gameAudioLevel
	GameLineEdit.text = "%.0f%%" % (userPref.masterAudioLevel * 100)

	SfxVolumeSlider.value = userPref.sfxAudioLevel
	SfxLineEdit.text = "%.0f%%" % (userPref.masterAudioLevel * 100)

	VoiceVolumeSlider.value = userPref.voiceAudioLevel
	VoiceLineEdit.text = "%.0f%%" % (userPref.masterAudioLevel * 100)

	MusicVolumeSlider.value = userPref.musicAudioLevel
	MusicLineEdit.text = "%.0f%%" % (userPref.masterAudioLevel * 100)

func _on_return_button_pressed():
	userPref.save()
	queue_free()


func _on_Master_slider_value_changed(value):
	userPref.masterAudioLevel = value
	MasterLineEdit.text = "%.0f%%" % (value * 100)
	GlobalVars.Mastervolume = value
	_update_audio_bus("Master", value)

func _on_Master_line_edit_text_changed(new_text):
	var cleaned_text = new_text.strip_edges().replace("%", "")
	var new_value = clamp(float(cleaned_text) / 100.0, 0.0, 1.0)
	userPref.masterAudioLevel = new_value
	GlobalVars.Mastervolume = new_value
	MasterVolumeSlider.value = new_value
	_update_audio_bus("Master", new_value)


func _on_Game_slider_value_changed(value):
	userPref.gameAudioLevel = value
	GameLineEdit.text = "%.0f%%" % (value * 100)
	GlobalVars.Gamevolume = value
	_update_audio_bus("Game", value)


func _on_Game_line_edit_text_changed(new_text):
	var cleaned_text = new_text.strip_edges().replace("%", "")
	var new_value = clamp(float(cleaned_text) / 100.0, 0.0, 1.0)
	userPref.gameAudioLevel = new_value
	GlobalVars.Gamevolume = new_value
	GameVolumeSlider.value = new_value
	_update_audio_bus("Game", new_value)


func _on_Sfx_slider_value_changed(value):
	userPref.sfxAudioLevel = value
	SfxLineEdit.text = "%.0f%%" % (value * 100)
	GlobalVars.SFXvolume = value
	_update_audio_bus("SFX", value)


func _on_Sfx_line_edit_text_changed(new_text):
	var cleaned_text = new_text.strip_edges().replace("%", "")
	var new_value = clamp(float(cleaned_text) / 100.0, 0.0, 1.0)
	userPref.sfxAudioLevel = new_value
	GlobalVars.SFXvolume = new_value
	SfxVolumeSlider.value = new_value
	_update_audio_bus("SFX", new_value)


func _on_Voice_slider_value_changed(value):
	userPref.voiceAudioLevel = value
	VoiceLineEdit.text = "%.0f%%" % (value * 100)
	GlobalVars.Voicevolume = value
	_update_audio_bus("Voice", value)


func _on_Voice_line_edit_text_changed(new_text):
	var cleaned_text = new_text.strip_edges().replace("%", "")
	var new_value = clamp(float(cleaned_text) / 100.0, 0.0, 1.0)
	userPref.voiceAudioLevel = new_value
	GlobalVars.Voicevolume = new_value
	VoiceVolumeSlider.value = new_value
	_update_audio_bus("Voice", new_value)


func _on_Music_slider_value_changed(value):
	userPref.musicAudioLevel = value
	MusicLineEdit.text = "%.0f%%" % (value * 100)
	GlobalVars.Musicvolume = value
	_update_audio_bus("Music", value)


func _on_Music_line_edit_text_changed(new_text):
	var cleaned_text = new_text.strip_edges().replace("%", "")
	var new_value = clamp(float(cleaned_text) / 100.0, 0.0, 1.0)
	userPref.musicAudioLevel = new_value
	GlobalVars.Musicvolume = new_value
	MusicVolumeSlider.value = new_value
	_update_audio_bus("Music", new_value)

func _update_audio_bus(bus_name: String, volume: float):
	var db_volume = linear_to_db(volume)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(bus_name), db_volume)

func linear_to_db(linear: float) -> float:
	if linear == 0:
		return -80
	return 20 * (log(linear) / log(10.0))


func _on_WindowMode_option_button_item_selected(index):
	match index:
		#FullScreen
		0:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
			centre_window()
		#Window Mode
		1:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
			centre_window()
		#Borderless Window
		2:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
			centre_window()
		#Borderless Window
		3:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
			centre_window()

#force update window to be the center of the screen
func centre_window():
	var centre_screen = DisplayServer.screen_get_position() + DisplayServer.screen_get_size()/2
	var window_size = get_window().get_size_with_decorations()
	get_window().set_position(centre_screen - window_size/2)

#add all the items in the GameMode's windows mode array
func add_window_mode_items() -> void:
	for i in GlobalVars.windowModeArray:
		windowModeButton.add_item(i)

	#making button default to fullscreen
	windowModeButton.select(0)

#add all the items in the GameMode's resolution dictonary
func add_resolution_selected() -> void:
	for i in GlobalVars.resolutionDictionary:
		resolutionsButton.add_item(i)

	#making button default to 1920x1080
	resolutionsButton.select(10)
