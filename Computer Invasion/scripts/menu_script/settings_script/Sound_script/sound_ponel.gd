extends Control

@onready var sound_controller = $MarginContainer/VBoxContainer/Sound_controller
@onready var sound_controller_3 = $MarginContainer/VBoxContainer/Sound_controller3
@onready var sound_controller_2 = $MarginContainer/VBoxContainer/Sound_controller2

func _ready():
	var audio_settings = SaveLodeSettings.load_audio_settings()
	
	if audio_settings != {}:
		sound_controller.set_data(audio_settings.Master)
		sound_controller_3.set_data(audio_settings.Music)
		sound_controller_2.set_data(audio_settings.Sfx)

func bace_date():
	sound_controller.base_date()
	sound_controller_2.base_date()
	sound_controller_3.base_date()

func save_data():
	sound_controller.save_data()
	sound_controller_2.save_data()
	sound_controller_3.save_data()
