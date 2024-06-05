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
