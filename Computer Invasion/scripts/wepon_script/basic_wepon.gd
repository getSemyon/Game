extends Node3D
class_name Base_wepon

@onready var marker = $Marker3D
var MISSILE = preload("res://scripts/missele-bomb_script/missile.gd")

func faer():
	var m = MISSILE.instantiate()
	
	get_parent().get_parent().add_child(m)
	
	m.position = marker.global_position
