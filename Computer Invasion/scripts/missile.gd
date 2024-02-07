extends CharacterBody3D
class_name Missile

var velosity = Vector3.ZERO
var speed : float = 10.0

@export var live_timer: float = 2.0
@export var damege: float = 10.0

func _ready():
	velosity = global_transform.basis.z.normalized() * -1

func _physics_process(delta):
	live_timer -= delta
	if live_timer <= 0:
		queue_free() 
		
	#velosity = transform.basis.z.normalized() * -1
	
	var collision_info = move_and_collide(velosity, false)
	
	if collision_info:
		if not collision_info.get_collider() is Player or not collision_info.get_collider() is Enemy:
			queue_free()

func create_missile(missile : Missile, node : Node):
	#node.add_child(missile)
	node.add_child(missile)

func _on_area_3d_body_entered(body):
	if body is Player or body is Enemy:
		body.take_damege(damege)
		queue_free()
