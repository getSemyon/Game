extends Node3D

var Menager = load("res://scripts/menager.gd").new()

func _on_area_3d_body_entered(body):
	if body is Player:
		SaveLodeMenager.saving()
