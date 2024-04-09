extends Control
class_name PlayerInterface

@onready var heal_parametr = $Control/VBoxContainer/HealParametr
@onready var armor_parametr = $Control/VBoxContainer/ArmorParametr
@onready var wepon_name = $Wepon/WeponName

func HealProparti(value : int):
	heal_parametr.text = str(value)

func ArmorProparti(value : int):
	armor_parametr.text = str(value)
	
func WeponProparti(name : String):	wepon_name.text = name
