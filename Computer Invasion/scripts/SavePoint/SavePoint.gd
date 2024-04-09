extends Node3D

var Menager = load("res://scripts/menager.gd").new()

func _on_area_3d_body_entered(body):
	if body is Player:
		SaveLodeMenager.saving()


func _on_area_3d_body_exited(body):
	pass
	#if body is Player:
		#var temp = Menager.lode()
	
		#if temp:
			 #get_tree().change_scene_to(temp.scene)
