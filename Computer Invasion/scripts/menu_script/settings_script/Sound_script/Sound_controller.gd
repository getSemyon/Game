extends Control
class_name sound_controller

@export var text : String
@export var value : int

@onready var label = $HBoxContainer/Label
@onready var value_bar = $HBoxContainer/HScrollBar
@onready var bar_info = $HBoxContainer/Label2

@export_enum("Master", "Music", "Sfx") var type_slider : String
@export var bus_index : int

func _ready():
	label.text = text
	bar_info.text = str(value_bar.value * 100) + "%"
	
	bus_index = AudioServer.get_bus_index(type_slider)
	value_bar.value_changed.connect(_on_value_changed)
	
	value_bar.value = db_to_linear(
		AudioServer.get_bus_volume_db(bus_index)
	)

func _on_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))
	
	bar_info.text = str(value_bar.value * 100) + "%"

func base_date():
	value_bar.value = value
	bar_info.text = str(value_bar.value * 100) + "%"

func save_data():
	SaveLodeSettings.save_audio_setting(type_slider, value_bar.value)

func set_data(value):
	value_bar.value = value
	bar_info.text = str(value_bar.value * 100) + "%"
