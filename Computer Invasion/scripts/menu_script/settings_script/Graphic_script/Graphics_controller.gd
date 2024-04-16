extends Control

@export var Text : String
@export var Base_Index : int

@export_enum("windows_mode", "permission") var Type : String

@onready var label = $HBoxContainer/Label
@onready var option_button = $HBoxContainer/OptionButton

signal coise_item

func _ready():
	label.text = Text

func create_date(dictionary):
	for item in dictionary:
			option_button.add_item(item)
			
	base_chose()

func base_chose():
	option_button.selected = Base_Index
	coise_item.emit()

func _on_option_button_item_selected(index):
	coise_item.emit()

func get_chose():
	return option_button.selected

func set_chose(value: int):
	option_button.selected = value
	coise_item.emit()
