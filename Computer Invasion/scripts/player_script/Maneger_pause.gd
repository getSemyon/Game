extends Node3D
class_name maneger_pause

var pause : bool = false
@onready var pause_menu___setting = $"../pause_menu - setting"

func _unhandled_input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		pause = !pause
	
		if pause:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			
		get_tree().paused = pause
		pause_menu___setting.visible = pause
