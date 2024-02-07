extends Control
class_name PlayerInterface

@onready var heal_parametr = $PanelContainer/VBoxContainer/Heal/HealParametr
@onready var armor_parametr = $PanelContainer/VBoxContainer/Armor/ArmorParametr
@onready var wepon_name = $PanelContainer/VBoxContainer/Wepon/WeponName

func HealProparti(value : int):
	heal_parametr.text = str(value)

func ArmorProparti(value : int):
	armor_parametr.text = str(value)
	
func WeponProparti(name : String):
	wepon_name.text = name
