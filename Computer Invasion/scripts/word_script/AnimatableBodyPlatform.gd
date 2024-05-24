extends AnimatableBody3D

@onready var parent : Node3D = get_parent()

func _physics_process(delta):
	global_position = parent.global_position
