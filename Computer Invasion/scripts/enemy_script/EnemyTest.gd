extends Enemy

func _on_target_area_body_entered(body):
	if body is Player:
		state = ALERT
		target = body
		#print("target")


func _on_target_area_body_exited(body):
	print("untarget")
	sleep()
