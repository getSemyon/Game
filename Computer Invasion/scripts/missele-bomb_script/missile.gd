extends CharacterBody3D
class_name Missile

var dif = Vector3.ZERO
var speed : float = 20.0

@export var live_timer: float = 2.0
@export var damege: float = 1.0

func _physics_process(delta):
	live_timer -= delta
	if live_timer <= 0:
		queue_free() 
	#
	dif = transform.basis * Vector3(0, 0, -speed) * delta
	var collision_info = move_and_collide(dif, false)
	
	if collision_info:
		queue_free()


func _on_area_3d_area_entered(area):
	area.get_parent()._take_damege(damege)
	queue_free()
