extends Enemy
class_name Enemy_shoter

# shoter
const missile = preload("res://scen/Enemy_scen/missile.tscn")
@onready var marker = $Marker3D

func attack(player : Player):
	var m = missile.instantiate()
	get_parent().add_child(m)
	
	m.damege = damage
	m.position = marker.global_position
	m.velosity = target.global_position - m.global_position
	reset_time_attack()
