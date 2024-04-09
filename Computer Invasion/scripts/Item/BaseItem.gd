extends Node3D
class_name BaseItem

func ready():
	$AnimationPlayer.play("idel_item_animation")

func _on_area_3d_body_entered(body):
	if body.is_in_group("player"):
		proparti(body)
		queue_free()

func proparti(target : Player):
	pass

func get_data():
	return name
