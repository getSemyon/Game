extends Node

#var player_position : Vector3 = Vector3.ZERO
#var player_wepon_list : Dictionary = {}
#var player_wepon_id_checked : int = 0
#var player_count_jump_max : int = 0
#var plyer_spin_on : bool = false
#
#var loaded_player_data : Dictionary = {}
#
#func _ready():
	##handel_segnal()
	##create_player_dictinori()
	#pass
#
#func create_player_dictinori() -> Dictionary:
	#var setting_controler_dick : Dictionary = {
		#"player_position" : player_position,
		#"player_wepon_list" : player_wepon_list,
		#"player_wepon_id_checked" : player_wepon_id_checked,
		#"player_count_jump_max" : player_count_jump_max,
		#"plyer_spin_on" : plyer_spin_on
	#}
	#
	#return setting_controler_dick
#
#func handel_segnal() -> void:
	#SignalBus.on_player_position.connect(set_player_position)
	#SignalBus.on_player_wepon_list.connect(set_player_wepon_list)
	#SignalBus.on_player_wepon_id_checked.connect(set_player_wepon_id_checked)
	#SignalBus.on_player_count_jump_max.connect(set_player_count_jump_max)
	#SignalBus.on_plyer_spin_on.connect(set_plyer_spin_on)
	#
	#SignalBus.load_player_data.connect(on_player_data_load)
#
#func on_player_data_load(data : Dictionary) -> void:
	#loaded_player_data = data
	#print(str(loaded_player_data))
	#
	#set_player_position(loaded_player_data["player_position"])
	#set_player_wepon_list(loaded_player_data["player_wepon_list"])
	#set_player_wepon_id_checked(loaded_player_data["player_wepon_id_checked"])
	#set_player_count_jump_max(loaded_player_data["player_count_jump_max"])
	#set_plyer_spin_on(loaded_player_data["plyer_spin_on"])
#
## get function
#func get_player_position() -> Vector3:
	#if loaded_player_data == {}:
		#return Vector3.ZERO
	#return player_position
#
#func get_player_wepon_list() -> Dictionary:
	#if loaded_player_data == {}:
		#return {}
	#return player_wepon_list
#
#func get_player_wepon_id_checked() -> int:
	#if loaded_player_data == {}:
		#return 0
	#return player_wepon_id_checked
#
#func get_player_count_jump_max() -> int:
	#if loaded_player_data == {}:
		#return 0
	#return player_count_jump_max
#
#func get_plyer_spin_on() -> bool:
	#if loaded_player_data == {}:
		#return false
	#return plyer_spin_on
#
## set function
#func set_player_position(position : Vector3):
	#player_position = position
#
#func set_player_wepon_list(wepon_list : Dictionary):
	#player_wepon_list = wepon_list
#
#func set_player_wepon_id_checked(id_checked : int):
	#player_wepon_id_checked = id_checked
#
#func set_player_count_jump_max(count_jump_max : int):
	#player_count_jump_max = count_jump_max
#
#func set_plyer_spin_on(spin_on : bool):
	#plyer_spin_on = spin_on
#
