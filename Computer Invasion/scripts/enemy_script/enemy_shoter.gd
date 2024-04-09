extends Enemy
class_name Enemy_shoter

# shoter
var missile = preload("res://scen/missile and bomb/missile.tscn")
@onready var marker = $Marker3D

func attack(player : Player):
	var m = missile.instantiate()
	
	m.damege = damage
	m.position = marker.global_position
	m.transform.basis = global_transform.basis
	
	get_parent().add_child(m)

	reset_time_attack()
