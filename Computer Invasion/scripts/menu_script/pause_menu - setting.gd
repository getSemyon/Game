extends ColorRect

@onready var pause_menu = $pause_menu
@onready var settings = $Settings

var size_window

func _ready():
	size_window = get_viewport().get_visible_rect().size
	settings.position.x += size_window.x
	
func settings_presed(movement_window : int):
	position.x -= movement_window

func _on_settings_signal_presed():
	settings_presed(-size_window.x)

func _on_pause_menu_settings_presed():
	settings_presed(size_window.x)

func continion_function():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().paused = false
	visible = false

func _on_pause_menu_continion_presed():
	continion_function()
