extends ProgressBar

@onready var timer = $Timer
@onready var damage_bar = $DemageBar

var proparti_value = 0 : set = _set_health

func _set_health(new_proparti_value):
	var prev_health = proparti_value
	proparti_value = min(max_value, new_proparti_value)
	value = proparti_value
	if proparti_value <= 0:
		print("You dead")
		
	if proparti_value < prev_health:
		timer.start()
	else:
		damage_bar.value = proparti_value
		
func init_health(_health):
	proparti_value = _health
	max_value = proparti_value
	value = proparti_value
	damage_bar.max_value = proparti_value
	damage_bar.value = proparti_value

func _on_timer_timeout():
	damage_bar.value = proparti_value
