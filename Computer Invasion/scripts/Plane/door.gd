extends Node3D
class_name Door

@onready var animation_player = $AnimationPlayer

func _on_button_interacted(body):
	animation_player.play("Open")
