extends Control

@export var Text : String
@export var actionName : String

@onready var label = $HBoxContainer/Label
@onready var button = $HBoxContainer/Button

func _ready():
	label.text = Text
	button.text = InputMap.action_get_events(actionName)

func get_data():
	return button.text

func set_data(actionName_new : String):
	label.text = actionName_new
	button.text = InputMap.action_get_events(actionName_new)
