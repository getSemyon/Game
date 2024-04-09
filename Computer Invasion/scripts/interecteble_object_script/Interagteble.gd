extends StaticBody3D
class_name Interactable

signal interacted(body)

@export var prompt_message = "Interact"
@export var prompt_action = "interact"

func get_prompt():
	var key_name = ""
	var action = InputMap.action_get_events(prompt_action)
	key_name = action[0].as_text()[0]
	return prompt_message + "\n[" + key_name + "]"


func interact(body):
	emit_signal("interacted", body)


func _on_interacted(body):
	print("Interact")
