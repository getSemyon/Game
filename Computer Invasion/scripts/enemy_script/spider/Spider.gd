extends Node3D
class_name Spier

@export var move_speed: float = 5.0
@export var turn_speed: float = 1.0
@export var ground_offset: float = 0.5

@export var fl_spider_leg : spider_leg
var fl_leg : Node3D
@export var fr_spider_leg : spider_leg
var fr_leg : Node3D
@export var bl_spider_leg : spider_leg
var bl_leg : Node3D
@export var br_spider_leg : spider_leg
var br_leg : Node3D

@onready var progress_bar = $ProgressBar
@onready var bodi = $bodi

func _ready():
	fl_leg = fl_spider_leg.get_marker()
	fr_leg = fr_spider_leg.get_marker()
	bl_leg = bl_spider_leg.get_marker()
	br_leg = br_spider_leg.get_marker()
	
	var label : Label = progress_bar.get_child(1)
	label.text = "Бос Паук"

func _process(delta):
	var plane1 = Plane(bl_leg.global_position, fl_leg.global_position, fr_leg.global_position)
	var plane2 = Plane(fr_leg.global_position, br_leg.global_position, bl_leg.global_position)
	
	var avg_normal = ((plane1.normal + plane2.normal) / 2).normalized()
	
	var target_basis = _basis_from_normal(avg_normal)
	
	transform.basis = lerp(transform.basis, target_basis, move_speed * delta).orthonormalized()

	var avg = (fl_leg.position + fr_leg.position + bl_leg.position + br_leg.position) / 4
	var target_pos = avg + transform.basis.y * ground_offset
	var distance = transform.basis.y.dot(target_pos - position)
	
	var new_position = position + transform.basis.y * distance
	new_position.y += 0.5
	position = lerp(position, new_position, move_speed * delta)
	_handle_movement(delta)
	
func _handle_movement(delta):
	translate(Vector3(-1, 0, 0) * move_speed * delta)
	#rotate_object_local(Vector3.UP, 1 * turn_speed * delta)
	
func _basis_from_normal(normal: Vector3) -> Basis:
	var result = Basis()
	result.x = normal.cross(transform.basis.z)
	result.y = normal
	result.z = transform.basis.x.cross(normal)
	
	result = result.orthonormalized()
	result.x *= scale.x 
	result.y *= scale.y 
	result.z *= scale.z 
	
	return result
