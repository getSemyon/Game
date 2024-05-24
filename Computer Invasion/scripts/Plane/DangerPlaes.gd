extends Node3D
class_name DangerPlane

var time_attack_max = 1
var time_attack = 0

var target : Player = null
@export var damage = 10

@onready var gpu_particles = $GPUParticles3D

func _ready():
	var P = roundi(scale.x * scale.y)
	gpu_particles.amount *= gpu_particles.amount % P 

func _process(delta):
	if time_attack > 0:
		time_attack -= delta
	
	if target:
		if time_attack <= 0:
			target._take_damege(damage)
			time_attack = time_attack_max

func _on_area_3d_area_entered(area):
	target = area.get_parent()
	if time_attack <= 0:
			target._take_damege(damage)
			time_attack = time_attack_max

func _on_area_3d_area_exited(area):
	target = null
	time_attack = 0
