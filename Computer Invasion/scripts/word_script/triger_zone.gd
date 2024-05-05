extends Node3D

@export var replaced : bool = false
signal enter_triger

func _on_area_3d_body_entered(body):
	if body is Player:
		enter_triger.emit()
	
		if !replaced:
			queue_free()
