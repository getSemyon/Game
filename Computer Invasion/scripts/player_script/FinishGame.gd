extends ColorRect

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().paused = true

func _on_button_2_pressed():
	get_tree().quit()
