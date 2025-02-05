extends enemyHaracter
class_name  StateChervack
#item enemy
@onready var path = $Collision_Helper/Path3D
@onready var path_follow = %PathFollow3D
@onready var head = %Head
@onready var partical_dae = $ParticalDae
@onready var timer = $Timer

#move poram
var targetPoint : Vector3 = Vector3.ZERO
var roundInt : int
var velosity_in : Vector3 = Vector3(-1, 0,0)
var velosity_out : Vector3 = Vector3(1, 0,0)
var progres_old_curve : Vector3

@onready var collision_helper = $Collision_Helper
@onready var area_damage = %AreaDamage

#bouns param
@onready var bounds = $Collision_Helper/Bounds

var bound_distnce = 0.1
var position_holver

#Attack poram
var isAttack = false
var time_next_attack : float = 0.25
var time : float = 0

func _ready():
	randomize()
	roundInt = randi_range(5,10)
	
	var curve_old : Curve3D = path.curve
	
	var new_curve = Curve3D.new()
	new_curve.add_point(curve_old.get_point_position(0), curve_old.get_point_in(0), curve_old.get_point_out(0))
	new_curve.add_point(curve_old.get_point_position(1), curve_old.get_point_in(1), curve_old.get_point_out(1))
	
	path.curve = new_curve

func _process(delta): 
	if !isDead:
		position_holver = head.global_position
		path_follow.progress += speed * delta
		
		#area_damage.position = head.global_position
		area_damage.global_rotation = head.global_rotation

		if isAttack:
			if time <= 0:
				target._take_damege(damage)
				time = time_next_attack
			time -= delta
		
		_harassment(delta)
		
		if path_follow.progress_ratio >= 0.95:
			_create_point()

func _move(delta):
	var p2 = global_position
	var p0 = targetPoint
	var p1 = (p2 - p0) / 2
	
	var q0 = p0.lerp(p1, 1)
	var q1 = p1.lerp(p2, 1)

func _create_point():
	if state == State.IDEL:
		targetPoint = global_position + Vector3(randi_range(-roundInt, roundInt), randi_range(-roundInt, roundInt), randi_range(-roundInt, roundInt))
		if target != null:
			state = State.ALERT
	elif state == State.ALERT:
		targetPoint = target.global_position
		state = State.IDEL
	
	if targetPoint.y < 0:
		targetPoint.y *= -1
	
	if targetPoint.y > 20:
		targetPoint.y = 20
	
	path.curve.add_point(to_local(targetPoint), velosity_in, velosity_out)
	progres_old_curve = path.curve.sample_baked(path_follow.progress)
	
	if path.curve.point_count > 3:
		path.curve.remove_point(0)
		path_follow.progress = path.curve.get_closest_offset(progres_old_curve)

func _harassment(delta):
	var bound = bounds.get_child(0)
	#var old_position = bound.global_position
	var old_transform = head.global_transform
	
	var temp_transform
	#var temp_position
	
	if position_holver.distance_to(bound.global_position) >= bound_distnce:
		#bound.global_position = position_holver
		bound.global_transform = old_transform
		
		for i in bounds.get_child_count() - 1:
			bound = bounds.get_child(i+1)
			
			#temp_position = bound.global_position
			#bound.global_position = old_position
			#old_position = temp_position
			
			temp_transform = bound.global_transform
			bound.global_transform = old_transform
			old_transform = temp_transform

func _death():
	area_damage.queue_free()
	collision_helper.queue_free()
	partical_dae.global_position = head.global_position
	partical_dae.emitting = true
	timer.start()

#Tareget Area
func _on_area_target_area_entered(area):
	target = area.get_parent()
	state = State.ALERT

func _on_area_target_area_exited(area):
	target = null
	state = State.IDEL

#Attack Area
func _on_area_attack_area_entered(area):
	isAttack = true

func _on_area_attack_area_exited(area):
	isAttack = false
	time = 0
