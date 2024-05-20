extends Node3D
class_name DangerPlane

var time_attack_max = 1
var time_attack = 0

var player : Player = null
@export var damage = 10

@onready var gpu_particles_3d = $GPUParticles3D

func _ready():
	var P = roundi(scale.x * scale.y)
	gpu_particles_3d.amount *= gpu_particles_3d.amount % P 

func _process(delta):
	if time_attack > 0:
		time_attack -= delta
	
	if player:
		if time_attack <= 0:
			player.take_damege(damage)
			time_attack = time_attack_max

func _on_area_3d_body_entered(body):
	if body.has_method("take_damege"):
		player = body
		if time_attack <= 0:
			body.take_damege(damage)
			time_attack = time_attack_max


func _on_area_3d_body_exited(body):
	player = null
	time_attack = 0
