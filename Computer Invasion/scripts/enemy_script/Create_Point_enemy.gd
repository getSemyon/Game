extends Node3D

@export_dir var enemy

@onready var parical_create = $ParicalCreate
@onready var timer = $Timer

func _ready():
	start()

func start():
	parical_create.emitting = true
	timer.start()

func create():
	var en = load(enemy).instantiate()
	en.position = global_position
	get_parent().add_child(en)

func _on_timer_timeout():
		create()
