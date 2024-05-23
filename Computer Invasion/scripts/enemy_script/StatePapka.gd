extends enemyHaracter
class_name statePapka

@onready var attack_point = $Collision_Helper/AttackPoint
@onready var nav_agent = $Collision_Helper/NavigationAgent3D
@onready var animation_player = $Collision_Helper/AnimationPlayer

@onready var partical_dae = $ParticalDae
@onready var timer = $Timer
@onready var collision_helper = %Collision_Helper
@onready var area_damage = $AreaDamage

func _ready():
	state = State.IDEL

func _process(delta):
	if !isDead:
		velocity = Vector3.ZERO
		
		if state == State.ALERT:
			animation_player.play("alert")
			
			nav_agent.set_target_position(target.global_transform.origin)
			var next_nav_point = nav_agent.get_next_path_position()
			velocity = (next_nav_point - global_transform.origin).normalized() * speed
			rotation.y = lerp_angle(rotation.y, atan2(-velocity.x, -velocity.z), delta * speed)
			
			if _heigh_target() > 1:
				state = State.IDEL
			
			move_and_slide()
			return
		elif state == State.ATTACK:
			animation_player.play("attack")
			return
		elif state == State.IDEL:
			if target != null && _heigh_target() < 1:
				state = State.ALERT
			return

func _heigh_target():
	var velositi_position = target.global_position - global_position
	return velositi_position.y

func _death():
		area_damage.queue_free()
		collision_helper.queue_free()
		partical_dae.emitting = true
		timer.start()

func _on_timer_timeout():
	queue_free()

#Area attack
func _on_area_attack_area_entered(area):
	state = State.ATTACK

func _on_area_attack_area_exited(area):
	state = State.ALERT

# Area target
func _on_area_target_area_entered(area):
	target = area.get_parent()
	state = State.ALERT

func _on_area_target_area_exited(area):
	target = null
	state = State.IDEL
