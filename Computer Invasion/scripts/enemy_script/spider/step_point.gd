extends RayCast3D

@onready var step_target = $Marker3D
@onready var addition = $Addition


func _physics_process(delta):
	var hit_point = get_collision_point()
	if hit_point:
		step_target.global_position = hit_point
	else:
		hit_point = addition.get_collision_point()
		if hit_point:
			step_target.global_position = hit_point
