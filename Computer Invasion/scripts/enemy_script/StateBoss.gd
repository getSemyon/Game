extends enemyHaracter

@onready var collision_helper = $Collision_Helper
@onready var partical_dae = $ParticalDae
@onready var timer = $Timer
@onready var nav_agent = $Collision_Helper/NavigationAgent3D
@onready var progress_bar = $ProgressBar
@onready var animation_player = $Collision_Helper/AnimationPlayer
@onready var attack_point = $Collision_Helper/AttackPoint
@onready var area_damage = $AreaDamage

var init_shoot : int = 20
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	var name_scen = get_tree().current_scene.name
	target = get_tree().get_root().get_node(name_scen +"/Player")
	state = State.ALERT
	
	var label : Label = progress_bar.get_child(1)
	label.text = "БОСС"
	progress_bar.init_health(heal)

func _process(delta):
	if !isDead:
		velocity = Vector3.ZERO
		
		nav_agent.set_target_position(target.global_transform.origin)
		var next_nav_point = nav_agent.get_next_path_position()
		velocity = (next_nav_point - global_transform.origin).normalized() * speed
		rotation.y = lerp_angle(rotation.y, atan2(-velocity.x, -velocity.z), delta * speed)
		
		if state == State.ALERT:
			animation_player.play("alert")
			
			if _heigh_target() > 2:
				state = State.SHOOT
			
			move_and_slide()
			return
		elif state == State.ATTACK:
			animation_player.play("attack")
			return
		elif state == State.SHOOT:
			animation_player.play("shoot")
			if _heigh_target() < 2:
				state = State.ALERT
			return

func _heigh_target():
	var velositi_position = target.global_position - global_position
	return velositi_position.y

func _shoot():
	#attack_point.transform = transform
	var distance =  Vector2(attack_point.global_position.x, attack_point.global_position.z).distance_to(Vector2(target.global_position.x, target.global_position.z)) + target.global_position.y - attack_point.global_position.y
	var sin_angel = distance / (init_shoot * init_shoot) * gravity
	attack_point.rotation.x = asin(sin_angel) * 2
	
	var melee = load("res://scen/missile and bomb/boss_melee.tscn").instantiate()
	melee.time_life = 3*init_shoot*sin_angel/gravity
	get_parent().add_child(melee)
	
	melee.global_position = attack_point.global_position
	melee.transform = attack_point.global_transform
	
	var der = (melee.transform.basis * Vector3(0, 0, 1)).normalized() * -init_shoot
	melee.apply_central_impulse(der)
	

func _death():
	area_damage.queue_free()
	collision_helper.queue_free()
	partical_dae.emitting = true
	target.endGame()
	timer.start()

func _on_timer_timeout():
	queue_free()

func _take_damege(dm : int):
	heal -= dm
	progress_bar._set_health(heal)
	if heal <= 0:
		isDead = true
		_death()
	state = State.ALERT
	
#Area attack
func _on_area_attack_area_entered(area):
	state = State.ATTACK

func _on_area_attack_area_exited(area):
	state = State.ALERT
