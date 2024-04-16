extends Node

var config = ConfigFile.new()
const SETTINGS_FILE_PATH = "user://settings.ini"

func _ready():
	if ! FileAccess.file_exists(SETTINGS_FILE_PATH):
		config.set_value("keybinding", "move_forward", "W")
		config.set_value("keybinding", "move_back", "S")
		config.set_value("keybinding", "move_right", "A")
		config.set_value("keybinding", "move_left", "D")
		config.set_value("keybinding", "jump", "Space")
		config.set_value("keybinding", "sprint", "Shift")
		config.set_value("keybinding", "croch", "Ctrl")
		config.set_value("keybinding", "shoot", "mouse_1")
		config.set_value("keybinding", "scrolUp", "mouse_4") 
		config.set_value("keybinding", "scrolDown", "mouse_5")
		config.set_value("keybinding", "spin_dash", "C")
		config.set_value("keybinding", "interact", "F")
		
		config.set_value("video", "window_mode", 1)
		config.set_value("video", "permission", 4)
		
		config.set_value("audio", "Master", 1.0)
		config.set_value("audio", "Music", 1.0)
		config.set_value("audio", "Sfx", 1.0)
		
		config.save(SETTINGS_FILE_PATH)
	else:
		config.load(SETTINGS_FILE_PATH)

func save_video_setting(key: String, value):
	config.set_value("video", key, value)
	config.save(SETTINGS_FILE_PATH)
	
func load_video_settings():
	var video_settings = {}
	for key in config.get_section_keys("video"):
		video_settings[key] = config.get_value("video", key)
	return video_settings
	
func save_audio_setting(key: String, value):
	config.set_value("audio", key, value)
	config.save(SETTINGS_FILE_PATH)
	
func load_audio_settings():
	var audio_settings = {}
	for key in config.get_section_keys("audio"):
		audio_settings[key] = config.get_value("audio", key)
	return audio_settings

func save_keybinding(action: StringName, event: InputEvent):
	var event_str
	if event is InputEventKey:
		event_str = OS.get_keycode_string(event.physical_keycode)
	elif event is InputEventMouseButton:
		event_str = "mouse_" + str(event.button_index)
		
	config.set_value("keybinding", action, event_str)
	config.save(SETTINGS_FILE_PATH)

func load_keybindings():
	var keybindings = {}
	var keys = config.get_section_keys("keybinding")
	for key in keys:
		var input_event
		var event_str = config.get_value("keybinding", key)
		
		if event_str.contains("mouse_"):
			input_event = InputEventMouseButton.new()
			input_event.button_index = int(event_str.split("_")[1])
		else:
			input_event = InputEventKey.new()
			input_event.keycode = OS.find_keycode_from_string(event_str)
		
		keybindings[key] = input_event
		
	return keybindings
