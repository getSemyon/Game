extends CharacterBody3D
class_name PlayerUI

# player interface
var player_interface : PlayerInterface = null

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
const missile = preload("res://scen/Enemy_scen/missile.tscn")

# wepon var
var wepon_list = {
	0 : ["NoneWepon", true],
	1 : ["Wepon1", false],
	2 : ["Wepon2", false]
}
var wepon_check : int = 1

# spel var
var spin_on = false
var pover_spin = 50
var spin_timer_max : int = 1
var spin_time = 0;

# jump var
var count_jump = 0
var count_jump_max = 0

# function
func take_damege(damege_enemy : int):
	print("damege")
	heal -= damege_enemy
	if heal <= 0:
		die()

func attack():
	print("atack")
	#var m = missile.instantiate()
	#m.create_missile(m, scen_point);
	#
	##get_parent().get_parent().add_child(m)
	#m.position = point_shoot.global_position
	#m.velocity = m.global_transform.basis.z.normalized() * -1
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
			return
