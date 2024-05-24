extends Path3D
class_name RunPlatform

@export_category("DATA")

@export var proces : bool = true
@export var factor : int = 10

@onready var path_follow_3d = $PathFollow3D
@onready var animation_player = $AnimationPlayer
@onready var remote_transform = $PathFollow3D/RemoteTransform3D

func _ready():
	#animation_player.track_set_path("PathFollow3D:progress_ratio")
	#var track = animation_player.root_motion_track
	#your_animation.track_insert_key(, factor, 1)
	#animation_player.get_animation("Move").length = factor
	#
	#var animation = animation_player.get_animation("Move")
	#animation.track_insert_key(0, factor, 1)
	animation_player.speed_scale /= factor
	animation_player.play("Move")
	
#func _process(delta):
	#if proces:
		#path_follow_3d.progress += delta * factor
		#
	#if path_follow_3d.progress_ratio >= 1 or path_follow_3d.progress_ratio <= 0:
		#factor *= -1
	#print(str(path_follow_3d.progress_ratio))
