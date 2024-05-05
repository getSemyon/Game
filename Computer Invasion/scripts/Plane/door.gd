extends Node3D
class_name Door

@export var isCloced : bool = false
@onready var animation_player = $AnimationPlayer
@onready var wall = $wall1

func _ready():
	if isCloced:
		wall.position.y = -1

func animation():
	
	print(str(isCloced))
	if isCloced:
		animation_player.play("Close")
	else:
		animation_player.play("Open")

func _on_button_interacted(body):
	animation()

func _on_triger_zone_2_enter_triger():
	animation()
