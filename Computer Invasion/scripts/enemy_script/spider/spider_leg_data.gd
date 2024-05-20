extends Node3D
class_name spider_leg

@onready var targetMarker = $targetMarker

@export var leg_mirov : bool
@onready var step_point = $StepPoint

@export var adjacent_target: spider_leg
@export var opposite_target: spider_leg

func _ready():
	if leg_mirov:
		step_point.rotation.z *= -1
		step_point.position.x *= -1
	
	targetMarker.adjacent_target = adjacent_target.get_marker()
	targetMarker.opposite_target = opposite_target.get_marker()

func get_marker():
	return targetMarker 
