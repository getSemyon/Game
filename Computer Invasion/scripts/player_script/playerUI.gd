extends CharacterBody3D
class_name PlayerUI

# player interface and resource
var player_interface : PlayerInterface = null
var slider: SliderJoint3D = null

# parametr player
@export var heal_export : int
@export var damage_export : int
@export var speed_export : float
@export var armor_export : int

var heal : int = heal_export
var damage : int = damage_export
var speed : float = speed_export
var armor : int = armor_export

# atack parametr
var point_shoot : Node3D
var scen_point : Node3D
var camera_angel : Vector3 = Vector3.ZERO
#const pach_missile : String = "res://scen/missile and bomb/physic_missile.tscn"
var missile = preload("res://scen/missile and bomb/physic_missile.tscn")

# wepon var
var wepon_list = {
	0 : ["NoneWepon", true],
	1 : ["Blater", false],
	2 : ["Hook", false],
	3 : ["Rocket", false],
	4 : ["Bomb", false]
}
var wepon_check : int = 0

# spel var
var spin_on = false
var pover_spin = 50
var spin_timer_max : int = 1
var spin_time = 0;

# jump var
var count_jump = 0
var count_jump_max = 0

# grappling var
var hook_pos = Vector3.ZERO
var hooked = false
var rey_hook : Node3D
var line_helper
var line 

# function
func take_damege(damege_enemy : int):
	print("damege")
	heal -= damege_enemy
	player_interface.HealProparti(-damege_enemy)
	
	if heal <= 0:
		die()

func attack():
	var m = missile.instantiate()
	
	m.type = 0
	m.position = point_shoot.global_position
	m.transform.basis = global_transform.basis
	m.rotation.x = camera_angel.x
	m.impulse()
	get_tree().get_root().add_child(m)
	
	pass

func die():
	print("playerDie")

func getProparti(type_proparti : int, count_proparti : int):
	match type_proparti:
		0:
			heal += count_proparti
			player_interface.HealProparti(count_proparti)
		1:
			armor += count_proparti
			player_interface.ArmorProparti(count_proparti)
		2:
			damage += count_proparti
		3:
			spin_on = count_proparti
		4:
			count_jump_max = count_proparti

func getWepon(wepon_id : int):
	wepon_list[wepon_id][1] = true
	print(wepon_list[wepon_id][0])
	wepon_list[0][1] = false

func weponScrol(ScrolIndex : int):
	while true:
		wepon_check += ScrolIndex
		
		if wepon_check >= 3:
			wepon_check = 0
			
		if wepon_check <= -1:
			wepon_check = 2
		
		if(wepon_list[wepon_check][1] == true):
			player_interface.WeponProparti(wepon_list[wepon_check][0])
			hooked = false
			line.hide()
			return

func spin(delta):
	velocity.x = lerp(velocity.x, velocity.x * pover_spin, 20 * delta)
	velocity.z = lerp(velocity.z, velocity.z * pover_spin, 20 * delta)
	spin_time = spin_timer_max

# Hook function
func hook():
	hook_pos = get_hook_position()
	
	if hook_pos != Vector3.ZERO:
		hooked = true

func get_hook_position():
	if rey_hook.is_colliding():
		line.show()
		return rey_hook.get_collision_point()
		
	return Vector3.ZERO
	
func swing(delta):
	var hook_radiuce_lenght = hook_pos.distance_to(transform.origin)
	
	velocity.y = 0
	
	if hook_radiuce_lenght > 1:
		transform.origin = lerp(transform.origin, hook_pos , 0.05)
	draw_hook(hook_radiuce_lenght)

func draw_hook(length: float) -> void:
	line_helper.look_at(hook_pos, Vector3.UP)
	line.height = length
	line.position.z = length / -2

# Safe and load parametr
func get_data():
	var data = {
		"transform" : transform,
		"wepon_list" : wepon_list,
		"wepon_check" : wepon_check,
		"spin_on" : spin_on,
		"heal" : heal,
		"armor" : armor,
		"damage" : damage
	}
	return data
	
func set_data(data : Dictionary):
	transform = data["transform"]
	wepon_list = data["wepon_list"]
	wepon_check = data["wepon_check"]
	spin_on = data["spin_on"]
	heal = data["heal"]
	armor = data["armor"]
	damage = data["damage"]

func Updateinterface():
	player_interface.ArmorProparti(armor)
	player_interface.HealProparti(heal)
	player_interface.WeponProparti(wepon_list[wepon_check][0])
