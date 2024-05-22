extends Node3D

@export_dir var enemy

@onready var parical_create = $ParicalCreate
@onready var timer = $Timer

func start():
	parical_create.emitting = true
	timer.start()

func create():
	var en = load(enemy).instantiate()
	en.position = global_position
	en.position.y += 0.5
	
	#if en is StateChervack:
		#var curve_old : Curve3D = en.get_child(0).get_child(1).curve
		#
		#var new_curve : Curve3D
		#new_curve.add_point(curve_old.get_point_position(0), curve_old.get_point_in(0), curve_old.get_point_out(0))
		#new_curve.add_point(curve_old.get_point_position(1), curve_old.get_point_in(1), curve_old.get_point_out(1))
		#
		#print(str(new_curve))
		#en.get_child(0).get_child(1).curve = new_curve
	
	get_parent().add_child(en)

func _on_timer_timeout():
		create()

func _on_button_interacted(body):
	start()

func _on_triger_zone_enter_triger():
	start()
