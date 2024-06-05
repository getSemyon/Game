extends Path3D
class_name RunPlatform

@export_category("DATA")

@export var proces : bool = true
@export var factor : int = 10

@onready var path_follow = $PathFollow3D
@onready var animation_player = $AnimationPlayer
#@onready var remote_transform = $PathFollow3D/RemoteTransform3D

func _ready():
	animation_player.speed_scale /= factor
	animation_player.play("Move")
