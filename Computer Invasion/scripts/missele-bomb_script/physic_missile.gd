extends RigidBody3D
class_name Rocket_Bomb_Rigenbody

@export_enum("BOMB", "ROCKET") var type
@export var damege = 25
var derection = []

@export var inpulce : float = 10.0

@onready var animation_player = $AnimationPlayer
@onready var timer = $Timer

@onready var mesh_instance_3d = $MeshInstance3D
@onready var area_3d = $Area3D
@onready var collision_shape_area = $Area3D2/CollisionShape3D
@onready var mesh_instance_3d_2 = $MeshInstance3D2
@onready var area_3d_2 = $Area3D2
@onready var collision_shape_3d = $CollisionShape3D

var is_destroy = false
var is_expensiv = false

func _ready():
	$Area3D2.hide()
	$Area3D2/CollisionShape3D.shape.radius = 0.001

#func _process(delta):
	#if is_destroy:
		#mesh_instance_3d_2.scale -= Vector3(delta, delta, delta) * 4
	#
	#if is_expensiv:
		#mesh_instance_3d_2.scale += Vector3(delta, delta, delta) * 2

func boom():
	area_3d_2.visible = true
	collision_shape_area.visible = true
	
	collision_shape_area.shape.radius = mesh_instance_3d_2.scale.x
	
	if derection != []:
		for obj in derection:
			if obj != null:
				obj.take_damege(damege)
	
func delete():
	collision_shape_3d.queue_free()
	queue_free()

func impulse():
	derection = []
	var der = (transform.basis * Vector3(0, 0, 1)).normalized() * -inpulce
	apply_central_impulse(der)
	
func timer_destroy():
	timer.wait_time = 0.5
	mesh_instance_3d_2.visible = true
	mesh_instance_3d.queue_free()
	mesh_instance_3d_2.scale = Vector3(2, 2, 2)
	boom()
	timer.start()

func timer_expensiv():
	timer.wait_time = 1.5
	mesh_instance_3d_2.visible = true
	mesh_instance_3d_2.scale = Vector3(0.01, 0.01, 0.01)
	timer.start()

func _on_area_3d_body_entered(body):
	if not body is Rocket_Bomb_Rigenbody:
		if type == 0:
			#is_expensiv = true
			#timer_expensiv()
			animation_player.play("rowth_of_arrea")
		elif  type == 1 :
			#is_destroy = true
			#timer_destroy()
			animation_player.play("area_compression")
			
		area_3d.queue_free()
		#collision_shape_3d.queue_free()

func _on_area_3d_2_body_entered(body):
	if body.has_method("take_damege"):
		derection.push_back(body)
		print(str(body))
	pass

func _on_timer_timeout():
	if is_expensiv == true:
		boom()
	delete()
