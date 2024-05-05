extends CharacterBody3D
class_name Enemy

# Enum state enemy
enum {
	IDEL,
	ALERT
}

# parametr enemy
@export var heal_export : int
@export var damage_export : int
@export var speed_export : float

var heal : int = heal_export
var damage : int = damage_export
var speed : float = speed_export

# speed atack enemy
var attack_periude : float = 0
@export var time_to_next_attack_export : float

var time_to_next_attack : float = time_to_next_attack_export

#target
var target : Player = null

# State enemy
var state = IDEL

# hidden var
var lerp_rotate : float = 10.0

@onready var nav_agent = $NavigationAgent3D


func _ready():
	heal = heal_export
	damage = damage_export
	speed = speed_export
	time_to_next_attack = time_to_next_attack_export
	
	attack_periude = time_to_next_attack

func _process(delta): 
	velocity = Vector3.ZERO
	
	if state == ALERT:
		if attack_periude > 0.0:
			attack_periude -= delta
		else:
			attack(target)
			
		nav_agent.set_target_position(target.global_transform.origin)
		var next_nav_point = nav_agent.get_next_path_position()
		velocity = (target.global_transform.origin - global_transform.origin).normalized() * speed
		rotation.y = lerp_angle(rotation.y, atan2(-velocity.x, -velocity.z), delta * 10.0)
		
	move_and_slide()

func sleep():
	state = IDEL

func take_damege(damege_playr : int):
	if target != null:
		target = get_parent().find_child('Player')
		state = ALERT
	heal -= damege_playr
	if heal <= 0:
		die()

func attack(player : Player):
	player.take_damege(damage)

	reset_time_attack()

func reset_time_attack():
	attack_periude = time_to_next_attack

func die():
	queue_free()
	
func _on_target_area_body_entered(body):
	if body is Player:
		state = ALERT
		target = body

func _on_target_area_body_exited(body):
	if body is Player:
		sleep()
