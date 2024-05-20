extends Node

const URL : String = "user://PlayerData.dat"

func saving():
	var file = FileAccess.open(URL, FileAccess.WRITE)
	
	var data = {
		"Items" : {},
		"Player" : {}
	}
	
	for obj in get_tree().get_nodes_in_group("save_load_item"):
		data["Items"][obj.name] = obj.get_data()
	
	var data_player = get_tree().get_first_node_in_group("player").get_data() 
	data["Player"].merge(data_player)
	
	file.store_var(data)
	file.close()
	print("save")

func loading():
	if not FileAccess.file_exists(URL):
		print("not save")
		return
		
	var file = FileAccess.open(URL, FileAccess.READ)
	
	if file:
		var data = file.get_var()
		for obj in get_tree().get_nodes_in_group("save_load_item"):
			if not data["Items"].has(obj.name):
				obj.queue_free()
		
		get_tree().get_first_node_in_group("player").set_data(data["Player"])
					
	file.close()
	#for obj in get_tree().get_nodes_in_group("save_load"):
		#if not data[obj.name]:
			#obj.queue_free()

#const SETTINGS_SAVE_PACH : String = "user://PlayerData.file"
#
#var setings_data_dict : Dictionary = {}
#
#func _ready():
	#SignalBus.save_palyer_data.connect(player_data_save)
	#player_data_loder()
	#pass
	#
#func  player_data_save(date : Dictionary) -> void:
	#var save_setting_data_file = FileAccess.open(SETTINGS_SAVE_PACH, FileAccess.WRITE)
	#
	#var json_data_string = JSON.stringify(date)
	#
	#save_setting_data_file.store_line(json_data_string)
#
#func player_data_loder() -> void:
	#if not FileAccess.file_exists(SETTINGS_SAVE_PACH):
		#return 
	#
	#var save_setting_data_file = FileAccess.open(SETTINGS_SAVE_PACH, FileAccess.READ)
	#var loaded_file : Dictionary = {}
	#
	#while save_setting_data_file.get_position() < save_setting_data_file.get_length():
		#var json_string = save_setting_data_file.get_line()
		#var json = JSON.new()
		#var _presed_result = json.parse(json_string)
		#
		#loaded_file = json.get_data()
		#
	#SignalBus.on_load_player_data(loaded_file)
	#loaded_file = {}
#
#
#func testSave(player : Player):
	#var save_player_data_file = FileAccess.open(SETTINGS_SAVE_PACH, FileAccess.WRITE)
	#
	#var data = {
		#"player" : player,
		#"player_position" : player.global_position
	#}
	#
	#var json_data_string = JSON.stringify(data)
	#
	#save_player_data_file.store_line(json_data_string)
	#
	#
#func testLoad():
	#if not FileAccess.file_exists(SETTINGS_SAVE_PACH):
		#return
	#
	#var player = get_tree().get_first_node_in_group("player")
	#var level = player.get_parent()
	#player.queue_free()
	#
	#var save_player_data_file = FileAccess.open(SETTINGS_SAVE_PACH, FileAccess.READ)
	#var loaded_file = {}
	#
	#while save_player_data_file.get_position() < save_player_data_file.get_length():
		#var json_string = save_player_data_file.get_line()
		#var json = JSON.new()
		#var _presed_result = json.parse(json_string)
		#
		#loaded_file = json.get_data()
		#
	#player = loaded_file["player"]
	#player.global_position = loaded_file["player_position"]
	#level.add_child(player)
	#loaded_file = {}
