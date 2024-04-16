extends Control

@onready var graphics_controller = $MarginContainer/VBoxContainer/Graphics_controller
@onready var graphics_controller_2 = $MarginContainer/VBoxContainer/Graphics_controller2

var GraphicsResurs = preload("res://Resurs/Graphics_resurs.gd").new()

func _ready():
	graphics_controller.create_date(GraphicsResurs.window_mode)
	graphics_controller_2.create_date(GraphicsResurs.permission)
	
	load_data()

func base_data():
	graphics_controller.base_chose()
	graphics_controller_2.base_chose()

func _on_graphics_controller_coise_item():
	var option = graphics_controller.find_child("HBoxContainer").find_child("OptionButton") as OptionButton;
	
	if GraphicsResurs.window_mode[option.selected] == "Ful-Scrin":
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func _on_graphics_controller_2_coise_item():
	var option = graphics_controller_2.find_child("HBoxContainer").find_child("OptionButton") as OptionButton;
	DisplayServer.window_set_size(GraphicsResurs.permission[option.get_item_text(option.selected)])

func save_date():
	SaveLodeSettings.save_video_setting("window_mode", graphics_controller.get_chose())
	SaveLodeSettings.save_video_setting("permission", graphics_controller_2.get_chose())

func load_data():
	var video_settings = SaveLodeSettings.load_video_settings()
	if video_settings != {}:
		graphics_controller.set_chose(video_settings.window_mode)
		graphics_controller_2.set_chose(video_settings.permission)
