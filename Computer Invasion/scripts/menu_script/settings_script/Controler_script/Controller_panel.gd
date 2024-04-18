extends Control
@onready var input_button_scene = preload("res://scen/Menu/Settings/Controller/controller_controller.tscn")
@onready var action_list = $ScrollContainer/VBoxContainer

var action_dictionari : Dictionary = {
	"move_forward" : "Двежение вперёт",
	"move_back" : "движение назад",
	"move_right" : "движение в право",
	"move_left" : "движение в лево",
	"jump" : "пргать",
	"sprint" : "ускоряться",
	"croch" : "присидать",
	"shoot" : "стрелять",
	"scrolUp" : "листать вверх",
	"scrolDown" : "листать вниз",
	"spin_dash" : "спин-деш",
	"interact" : "взоимодествовать"
}

var is_remapping = false
var action_to_remap = null
var remapping_button = null

func _ready():
	_load_keybindings_from_settings()
	_create_action_list()

func _load_keybindings_from_settings():
	var keybindings = SaveLodeSettings.load_keybindings()
	for action in keybindings.keys():
		InputMap.action_erase_events(action)
		InputMap.action_add_event(action, keybindings[action])

func _create_action_list():
	for item in action_list.get_children():
		item.queue_free()
	
	for action in action_dictionari:
		var button = input_button_scene.instantiate()
		var hstac = button.find_child("HBoxContainer")
		var action_label = hstac.find_child("Label")
		var input_label = hstac.find_child("Button")
		
		action_label.text = action_dictionari[action]
		
		var events = InputMap.action_get_events(action)
		if events.size() > 0:
			input_label.text = events[0].as_text().trim_suffix(" (Physical)")
		else:
			input_label.text = ""
			
		action_list.add_child(button)
		button.pressed.connect(_on_input_button_pressed.bind(button, action))
		
func _on_input_button_pressed(button, action):
	if !is_remapping:
		is_remapping = true
		action_to_remap = action
		remapping_button = button
		button.find_child("HBoxContainer").find_child("Button").text = "Press key to bind…"
		
func _input(event):
	if is_remapping:
		if (event is InputEventKey) || ((event is InputEventMouseButton) && event.pressed):
			InputMap.action_erase_events(action_to_remap)
			InputMap.action_add_event(action_to_remap, event)
			SaveLodeSettings.save_keybinding(action_to_remap, event)
			_update_action_list(remapping_button, event)
			
			is_remapping = false
			action_to_remap = null
			remapping_button = null
			
			accept_event()
	
func _update_action_list(button, event):
	button.find_child("HBoxContainer").find_child("Button").text = event.as_text().trim_suffix(" (Physical)")

func _on_reset_button_pressed():
	InputMap.load_from_project_settings()
	for action in action_dictionari:
		var events = InputMap.action_get_events(action)
		if events.size() > 0:
			SaveLodeSettings.save_keybinding(action, events[0])
	
	_create_action_list()
