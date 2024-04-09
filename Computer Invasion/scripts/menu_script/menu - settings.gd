extends Control

@onready var menu = $menu
@onready var settings = $Settings

var size_window

func _ready():
	size_window = get_viewport().get_visible_rect().size
	settings.position.x += size_window.x
	
func settings_presed(movement_window : int):
	position.x -= movement_window

func _on_menu_settings_choce():
	settings_presed(size_window.x)

func _on_settings_signal_presed():
	settings_presed(-size_window.x)
