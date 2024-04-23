extends Control
class_name PlayerInterface

@onready var heal_parametr = $info_player_margin/VBoxContainer/HealParametr
@onready var armor_parametr = $info_player_margin/VBoxContainer/ArmorParametr

@onready var wepon_sprite = $Wepon_pole_morgin/Wepon_sprite_controler/Wepon_sprite
var sprite_dictionari = {
	"Blater" : preload("res://sprite/Wepon_sprite/Blaster.atlastex"),
	"Hook" : preload("res://sprite/Wepon_sprite/Hook.atlastex"),
	"Rocket" : preload("res://sprite/Wepon_sprite/Rocet.atlastex"),
	"Bomb" : preload("res://sprite/Wepon_sprite/Bomb.atlastex"),
}

func init_proparti(heal, armor):
	heal_parametr.init_health(heal)
	armor_parametr.init_health(armor)

func HealProparti(value : int):
	heal_parametr.proparti_value += value

func ArmorProparti(value : int):
	armor_parametr.proparti_value += value
	
func WeponProparti(name : String):
	if name != "NoneWepon":
		wepon_sprite.texture = sprite_dictionari[name]
