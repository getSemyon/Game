extends Path3D
class_name RunPlatform

@export_category("DATA")

@export var proces : bool = true
@export var factor : int = 10

@onready var path_follow_3d = $PathFollow3D

func _process(delta):
	if proces:
		path_follow_3d.progress += delta * factor
		
	if path_follow_3d.progress_ratio >= 1 or path_follow_3d.progress_ratio <= 0:
		factor *= -1
	#print(str(path_follow_3d.progress_ratio))
