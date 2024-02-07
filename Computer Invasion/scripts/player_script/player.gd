extends PlayerUI
class_name Player

# Input var
var mouse_sens = 0.25
var direction = Vector3.ZERO

# Hinding var
var lerp_speed = 10.0
var air_lerp_speed = 3
var head_height = 0.0
var croching_depth = -1

# Slide var
var slider_timer = 0.0
var slider_timer_max = 1.0
var slide_vector = Vector2.ZERO

# States
var walking = false
var sprinting = false
var croching = false
var sliding = false
var free_look = false
var is_hanging = false
var idel = true

# Slide var
var slide_speed = 10.0

# Heng var
var hanging_timer = 0.0
var hanging_timer_max = 0.5

var hanging_stop_timer = 0
var hanging_stop_timer_max = 0.3

var position_hang = 0

# Head babbings var
const head_bebbing_sprintig_speed = 14.0
const head_brbbing_walking_speed = 10.0
const head_brbbing_croching_speed = 8.0

const head_bebbing_sprintig_inpletude = 0.2
const head_brbbing_walking_inpletude = 0.1
const head_brbbing_croching_inpletude = 0.05

var head_bennding_vector = Vector2.ZERO
var head_bennding_index = 0.0
var head_bennding_current_intesenti = 0.0

# Porament speed
var SPEED = 5.0
const CROICHING_SPEED = 3.0
const NORMAL_SPEED = 5.0
const SPRINTING_SPEED = 8.0
const SPLITING_SPEED = 10.0
const JUMP_VELOCITY = 4.5

# Nodes player
@onready var neck = $neck
@onready var head := $neck/head
@onready var eyse = $neck/head/eyse
@onready var normal_collision_shape_3d = $normal_CollisionShape3D
@onready var crochinng_collision_shape_3d = $crochinng_CollisionShape3D
@onready var head_ray = $HeadRay
@onready var rey_up_heng = $ReyUpHeng
@onready var reys_down_heng = $ReysDownHeng
@onready var animation_tree = $AnimationTree
@onready var camera = $neck/head/eyse/Camera3D
@onready var ray_corect = $RayCorect
@onready var basic_wepon = $basic_wepon

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	heal = heal_export
	damage = damage_export
	speed = speed_export
	point_shoot = $Marker3D
	scen_point = $basic_wepon
	player_interface = $PlayerInterface
	
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		if free_look:
			neck.rotate_y(deg_to_rad(-event.relative.x * mouse_sens))
			neck.rotation.y = clamp(neck.rotation.y, deg_to_rad(-120), deg_to_rad(120))
		else:
			rotate_y(deg_to_rad(-event.relative.x * mouse_sens))
			
		head.rotate_x(deg_to_rad(-event.relative.y * mouse_sens))
		head.rotation.x = clamp(head.rotation.x, deg_to_rad(-60), deg_to_rad(60))

func check_input():
	if Input.is_action_just_pressed("shoot"):
		#basic_wepon.faer()
		attack()
		return
	
	if Input.is_action_just_released("scrolUp"):
		weponScrol(1)
		return
		
	if Input.is_action_just_released("scrolDown"):
		weponScrol(-1)
		return
	
	if Input.is_action_just_pressed("ui_right"):
		camera.current = !camera.current
		return
		
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit() 
		return

func _unhandled_input(event):
	check_input()

func moving(delta, input_dir):	
	# Croching
	if Input.is_action_pressed("croch") or head_ray.is_colliding() or sliding:
		head.position.y = lerp(head.position.y, head_height + croching_depth, delta * lerp_speed)
		normal_collision_shape_3d.disabled = true
		crochinng_collision_shape_3d.disabled = false
		
		head_bennding_current_intesenti = head_brbbing_croching_inpletude
		head_bennding_index += head_brbbing_croching_speed * delta

		# Sliding
		if sliding:
			slider_timer -= delta
			if slider_timer <= 0:
				free_look = false
				sliding = false
			return lerp(SPEED, SPLITING_SPEED, delta * lerp_speed)
		
		if sprinting and input_dir != Vector2.ZERO and not sliding:
			sliding = true
			free_look = true
			slide_vector = input_dir
			slider_timer = slider_timer_max
		
		walking = false
		sprinting = false
		croching = true
		
		return lerp(SPEED, CROICHING_SPEED, delta * lerp_speed)
	
	normal_collision_shape_3d.disabled = false
	crochinng_collision_shape_3d.disabled = true
	head.position.y = lerp(head.position.y , head_height, delta * lerp_speed)
	
	# Sprinting
	if Input.is_action_pressed("sprint") and not croching:
		walking = false
		sprinting = true
		croching = false
		
		head_bennding_current_intesenti = head_bebbing_sprintig_inpletude
		head_bennding_index += head_bebbing_sprintig_speed * delta
		
		return lerp(SPEED, SPRINTING_SPEED, delta * lerp_speed)
	
	walking = true
	sprinting = false
	croching = false
	
	head_bennding_current_intesenti = head_brbbing_walking_inpletude
	head_bennding_index += head_brbbing_walking_speed * delta
	
	return lerp(SPEED, NORMAL_SPEED, delta * lerp_speed)

func find_nearest_angle(target_angle) -> float:
	
	var straight_angles = PI / 2
	var dif_nearest_angel = target_angle - straight_angles

	return dif_nearest_angel * -1

func chec_hange():
	var point_collider: Array
		
	if rey_up_heng.is_colliding() == true:
		return

	for rey in reys_down_heng.get_children():
		if not rey.is_colliding():
			is_hanging = false
			free_look = false
			return
		
		point_collider.push_back(rey.get_collision_point())
		

	var hegth = ray_corect.global_position.y - ray_corect.get_collision_point().y
	position_hang = global_position.y - hegth
			
	var player_position = global_position
	player_position.y = point_collider[0].y
	
	var vector_place = (point_collider[2] - point_collider[1]).normalized()
	var vector_player = (point_collider[0] - player_position).normalized()
	
	var angel = acos(vector_place.dot(vector_player)) / (vector_place.length() * vector_player.length())
	rotation.y -= find_nearest_angle(angel)
	hanging_stop_timer = hanging_stop_timer_max
		
	is_hanging = true
	free_look = true

func _physics_process(delta):
	# Rotation neck
	if neck.rotation.y != 0 and not is_hanging and not sliding:
		neck.rotation.y = lerp(neck.rotation.y, 0.0, delta * lerp_speed)
	
	# Heng
	if not is_hanging and hanging_timer <= 0 and not is_on_floor():
		chec_hange()
	elif not reys_down_heng.get_children()[0].is_colliding() and not sliding:
		is_hanging = false
		free_look = false
	
	if hanging_timer > 0:
		hanging_timer -= delta
	
	if hanging_stop_timer > 0:
		hanging_stop_timer -= delta
		
	# Input direction
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	
	# Add the gravity.
	if not is_on_floor() or is_hanging:
		if is_hanging:
			if global_position.y > position_hang:
				velocity.y -= gravity * delta
			else:
				velocity.y = 0.0
			
			if input_dir.y != 0 and hanging_stop_timer <= 0:
				if input_dir.y < 0:
					velocity.y = 1.5 * JUMP_VELOCITY
				is_hanging = false
				free_look = false
				hanging_timer = hanging_timer_max
		else:
			velocity.y -= gravity * delta
		
	# Moving
	SPEED = moving(delta, input_dir)
	
	# Bonning
	if is_on_floor() and not sliding and input_dir != Vector2.ZERO:
		head_bennding_vector.y = sin(head_bennding_index)
		head_bennding_vector.x = sin(head_bennding_index/2) * 0.5
		
		eyse.position.y = lerp(eyse.position.y, head_bennding_vector.y * (head_bennding_current_intesenti / 2), delta * lerp_speed)
		eyse.position.x = lerp(eyse.position.x, head_bennding_vector.x * head_bennding_current_intesenti, delta * lerp_speed)
	else:
		eyse.position.y = lerp(eyse.position.y, 0.0, delta * lerp_speed)
		eyse.position.x = lerp(eyse.position.x, 0.0, delta * lerp_speed)

	# Handle jump.
	if Input.is_action_just_pressed("jump"):
		if is_hanging and hanging_stop_timer <= 0:
			is_hanging = false
			free_look = false
			hanging_timer = hanging_timer_max
			velocity.y = 1.5 * JUMP_VELOCITY
		elif (is_on_floor() and not is_hanging) or count_jump > 0:
			#animation_tree.set("parameters/conditions/jump", true)
			velocity.y = JUMP_VELOCITY
			count_jump -= 1
			if sliding:
				sliding = false
				free_look = false
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if is_on_floor():
		count_jump = count_jump_max
		if sliding:
			direction = (transform.basis * Vector3(slide_vector.x, 0, slide_vector.y)).normalized()
			SPEED = (slider_timer + 0.1) * slide_speed
		else:
			direction = lerp(direction, (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized(), delta * lerp_speed)
	elif input_dir != Vector2.ZERO and not is_hanging:
		direction = lerp(direction, (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized(), delta * air_lerp_speed)
	elif is_hanging:
		direction = lerp(direction, (transform.basis * Vector3(input_dir.x, 0, 0)).normalized(), delta * lerp_speed)
	
	#if input_dir == Vector2.ZERO:
		#idel = true
	#else:
		#idel = false
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		#animation_tree.set("parameters/conditions/walk", true)
		#animation_tree.set("parameters/conditions/idel", false)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	if spin_time > 0:
		spin_time -= delta
	
	if Input.is_action_just_pressed("spin_dash"):
		if spin_on and spin_time <= 0 and not sliding:
			spin(delta)
	#input_dir.y *= -1
	#if is_on_floor():
		#animation_tree.set("parameters/conditions/idel", input_dir == Vector2.ZERO and not croching)
		#animation_tree.set("parameters/conditions/walk", input_dir != Vector2.ZERO and walking)
		#animation_tree.set("parameters/conditions/sprint", input_dir != Vector2.ZERO and sprinting)
		#animation_tree.set("parameters/conditions/croching", croching == true)
		#animation_tree.set("parameters/conditions/fall", false)
		#animation_tree.set("parameters/conditions/fall_flore", true)
		#
		#if walking:
			#animation_tree.set("parameters/walk/blend_position", input_dir)
			#
		#if sprinting:
			#animation_tree.set("parameters/sprint/blend_position", input_dir)
			#
		#if croching:
			#animation_tree.set("parameters/croching/blend_position", input_dir)
		#
		#animation_tree.set("parameters/conditions/slide", sliding == true)
		#animation_tree.set("parameters/conditions/runsSlide", sliding == true)
	#else:
		#animation_tree.set("parameters/conditions/fall_flore", false)
		#animation_tree.set("parameters/conditions/hang", is_hanging == true)
		#animation_tree.set("parameters/conditions/jump", false)
		#
		#if is_hanging:
			#animation_tree.set("parameters/hang/blend_position", input_dir.x)
			#animation_tree.set("parameters/conditions/fall", false)
		#else:
			#animation_tree.set("parameters/conditions/fall", true)
	
	move_and_slide()



func spin(delta):
	velocity.x = lerp(velocity.x, velocity.x * pover_spin, 20 * delta)
	velocity.z = lerp(velocity.z, velocity.z * pover_spin, 20 * delta)
	spin_time = spin_timer_max
