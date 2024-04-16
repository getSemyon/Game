extends Control
class_name  settings

signal signal_presed

@onready var controller_panel = $"MarginContainer/TabContainer/Управление/Controller_panel"
@onready var sound_ponel = $"MarginContainer/TabContainer/Звуки/Sound_ponel"
@onready var graphics_panel = $"MarginContainer/TabContainer/Графика/Graphics_panel"

func _on_button_pressed():
	signal_presed.emit()
	
	graphics_panel.save_date()
	sound_ponel.save_data()
	
func _on_button_2_pressed():
	graphics_panel.base_data()
	sound_ponel.bace_date()
	controller_panel._on_reset_button_pressed()
