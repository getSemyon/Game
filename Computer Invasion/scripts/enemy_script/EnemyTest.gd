extends Enemy_melee

func _on_target_area_body_entered(body):
	if body is Player:
		state = ALERT
		target = body


func _on_target_area_body_exited(body):
	if body is Player:
		print("untarget")
		sleep()
