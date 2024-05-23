extends RigidBody3D

@onready var timer = $Timer

var damege : int
var player : Player
var time_life: float

func _ready():
	timer.wait_time = time_life
	timer.start()

func _on_area_3d_area_entered(area):
	if area.get_parent() is Player:
		player = area.get_parent()
		player._take_damege(damege)
		queue_free()

func _on_area_3d_body_entered(body):
	if body != self:
		queue_free()

func _on_timer_timeout():
	queue_free()
