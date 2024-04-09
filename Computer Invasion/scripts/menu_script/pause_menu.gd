extends Control
class_name pause_menu

signal settings_presed
signal  continion_presed

func _on_button_2_pressed():
	continion_presed.emit()

func _on_button_3_pressed():
	settings_presed.emit()

func _on_button_4_pressed():
	get_tree().quit()
