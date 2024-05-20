extends Marker3D

@export var step_distance: float = 3.0

@export var step_point : Node3D
var step_target : Node3D

var adjacent_target: Marker3D
var opposite_target: Marker3D

var is_stepping := false

func _ready():
	step_target = step_point.get_child(0)
	step()

func _process(delta):
	if adjacent_target != null && opposite_target != null:
		if !is_stepping && !adjacent_target.is_stepping && abs(global_position.distance_to(step_target.global_position)) > step_distance:
			step()
			opposite_target.step()

func step():
	var target_pos = step_target.global_position
	var half_way = (global_position + step_target.global_position) / 2
	is_stepping = true
	
	var t = get_tree().create_tween()
	t.tween_property(self, "global_position", half_way + owner.basis.y, 0.1)
	t.tween_property(self, "global_position", target_pos, 0.1)
	t.tween_callback(func(): is_stepping = false)
