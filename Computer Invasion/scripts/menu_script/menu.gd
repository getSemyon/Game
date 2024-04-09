extends Control
class_name menu

signal settings_choce

const URL : String = "user://PlayerData.tres"
@onready var continion = $CenterContainer/MarginContainer/VBoxContainer/continion

func _ready():
	if not ResourceLoader.exists(URL):
		continion.disabled = true

func _on_button_pressed():
	if ResourceLoader.exists(URL):
		DirAccess.remove_absolute(URL)
	
	get_tree().change_scene_to_file("res://scen/testScen.tscn")

func _on_button_2_pressed():
	get_tree().change_scene_to_file("res://scen/testScen.tscn")

func _on_button_3_pressed():
	settings_choce.emit()

func _on_button_4_pressed():
	get_tree().quit() 
