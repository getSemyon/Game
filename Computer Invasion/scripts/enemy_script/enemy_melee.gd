extends Enemy
class_name Enemy_melee

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _process(delta): 
	if state == ALERT:
		var target_position = target.transform.origin
		var new_transform = transform.looking_at(target_position, Vector3.UP)
		transform  = transform.interpolate_with(new_transform, speed * delta)
		
		var velosity = target.global_position - global_position
		
		velosity.y = 0
			 
		var move_collide = move_and_collide(velosity.normalized() * delta * speed)
		
		if attack_periude > 0.0:
			attack_periude -= delta
		else:
			if move_collide and move_collide.get_collider() is Player:
				attack(target)
