extends RigidBody3D
class_name Bomb

@onready var viev = $CollisionShape3D
@onready var boom = %Boom
@onready var timer = $Timer

@export_dir var view 
@export var damege : int

var diraction = []

func _ready():
	if view != null:
		viev.get_child(0).queue_free()
		
		var obj = load(view).instantiate()
		obj.scale = Vector3(0.5, 0.5, 0.5)
		obj.rotation.x = -90
		
		viev.add_child(obj)

func _on_area_3d_area_entered(area):
	diraction.push_back(area.get_parent())

func _on_area_target_area_exited(area):
	var index = diraction.find(area.get_parent())
	diraction.remove_at(index)

func _on_area_collision_body_entered(body):
		if body != self:
			if timer.is_stopped() :
				timer.start()

func _boom():
	boomAnimation()
	
	for i in diraction:
		i._take_damege(damege)

func boomAnimation():
	for i : GPUParticles3D in boom.get_children():
		i.emitting = true

func _on_timer_timeout():
	sleeping = true
	viev.hide()
	_boom()

func _on_smoke_finished():
	queue_free()
