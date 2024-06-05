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

var heal : float = heal_export
var damage : int = damage_export
var speed : float = speed_export
var armor : float = armor_export

# atack parametr
var isShoot = false
var point_shoot : Node3D
var scen_point : Node3D
var camera_angel : Vector3 = Vector3.ZERO

# wepon var
var wepon_list = {
	0 : ["NoneWepon", true],
	1 : ["Blater", false, "res://scen/missile and bomb/missile.tscn"],
	2 : ["Hook", false],
	3 : ["Rocket", false, "res://scen/missile and bomb/rocket.tscn"],
	4 : ["Bomb", false, "res://scen/missile and bomb/bomb.tscn"]
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

var start_dealog = preload("res://dialoge/DialogeGame/StartDealog.gd")
var isLoding = false

# function
func _take_damege(damege_enemy : int):
	
	if armor > 0:
		if armor >= damege_enemy * 0.9:
			armor -= damege_enemy * 0.9
			heal -= damege_enemy * 0.1
			
			player_interface.ArmorProparti(-damege_enemy * 0.9)
			player_interface.HealProparti(-damege_enemy * 0.1)
		else:
			damege_enemy -= armor
			armor = 0
			heal -= damege_enemy
			
			player_interface.ArmorProparti(-armor)
			player_interface.HealProparti(-damege_enemy)
	else:
		heal -= damege_enemy
		player_interface.HealProparti(-damege_enemy)
	
	if heal <= 0:
		die()

func attack():
	if wepon_list[wepon_check].size() == 3:
		var m = load(wepon_list[wepon_check][2]).instantiate()
		
		if m is Missile:
			m.position = point_shoot.global_position
			m.transform.basis = global_transform.basis
			m.rotation.x = camera_angel.x
			get_tree().get_root().add_child(m)
		
		elif m is Rocket or m is Bomb:
			m.position = point_shoot.global_position
			m.transform.basis = global_transform.basis
			m.rotation.x = camera_angel.x
			
			get_tree().get_root().add_child(m)
			
			var der = (m.transform.basis * Vector3(0, 0, 1)).normalized() * -10
			m.apply_central_impulse(der)

func die():
	var dai_panel = preload("res://scen/Player/dae_panel.tscn").instantiate()
	remove_child($Maneger_pause)
	add_child(dai_panel)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().paused = true

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
			
			var text_button = InputMap.action_get_events("spin_dash")[0].as_text().trim_suffix(" (Physical)")
			DialogeState.text = "Вы подобрали спин деш! \n Что бы его активировать нажмите "+text_button
			add_child(load("res://dialoge/DialogeGame/start_dealog.tscn").instantiate())
		4:
			count_jump_max = count_proparti

func getWepon(wepon_id : int):
	wepon_list[wepon_id][1] = true
	DialogeState.text = "Вы получмли "+wepon_list[wepon_id][0]
	add_child(load("res://dialoge/DialogeGame/start_dealog.tscn").instantiate())
	
	wepon_list[0][1] = false
	weponScrol(1)

func weponScrol(ScrolIndex : int):
	while true:
		wepon_check += ScrolIndex
		
		if wepon_check >= wepon_list.size() - 1:
			wepon_check = 0
			
		if wepon_check <= -1:
			wepon_check = wepon_list.size() - 1
		
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

func endGame():
	var finshPlane = load("res://scen/Player/finish_game.tscn").instantiate()
	get_parent().add_child(finshPlane)

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
	
	isLoding = true

func Updateinterface():
	player_interface.ArmorProparti(armor)
	player_interface.HealProparti(heal)
	player_interface.WeponProparti(wepon_list[wepon_check][0])
