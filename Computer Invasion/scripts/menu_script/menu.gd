extends Control
class_name menu

signal settings_choce

const URL : String = "user://PlayerData.dat"
@onready var continion = $CenterContainer/MarginContainer/VBoxContainer/continion

func _ready():
	print(str(ResourceLoader.exists(URL)))
	if not FileAccess.file_exists(URL):
		continion.disabled = true

func _on_button_pressed():
	if FileAccess.file_exists(URL):
		DirAccess.remove_absolute(URL)
	
	get_tree().change_scene_to_file("res://scen/demo_wold.tscn")

func _on_button_2_pressed():
	get_tree().change_scene_to_file("res://scen/demo_wold.tscn")

func _on_button_3_pressed():
	settings_choce.emit()

func _on_button_4_pressed():
	get_tree().quit() 
