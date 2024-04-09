extends Node

# signal
signal save_palyer_data(setting_dick: Dictionary)
signal load_player_data(settings_data : Dictionary)

signal on_player_position(position : Vector3)
signal on_player_wepon_list(wepon_list : Dictionary)
signal on_player_wepon_id_checked(wepon_id_checked : int)
signal on_player_count_jump_max(count_jump : int)
signal on_plyer_spin_on(spin_on : bool)

# func save and lode
func on_save_player_data(data : Dictionary) -> void:
	save_palyer_data.emit(data)
	
func on_load_player_data(data : Dictionary) -> void:
	load_player_data.emit(data)

# func emit
func emit_player_position(position : Vector3) -> void:
	on_player_position.emit(position)
	
func emit_player_wepon_list(wepon_list : Dictionary) -> void:
	on_player_wepon_list.emit(wepon_list)
	
func emit_player_wepon_id_checked(wepon_id_checked : int) -> void:
	on_player_wepon_id_checked.emit(wepon_id_checked)
	
func emit_player_count_jump_max(count_jump : int) -> void:
	on_player_count_jump_max.emit(count_jump)
	
func emit_plyer_spin_on(spin_on : bool) -> void:
	on_plyer_spin_on.emit(spin_on)
