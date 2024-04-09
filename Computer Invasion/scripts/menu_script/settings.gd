extends Control
class_name  settings

signal signal_presed

func _on_button_pressed():
	signal_presed.emit()
