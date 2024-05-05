extends Enemy
class_name Charvak

@export var roundInt : int

var targetPoint : Vector3 = Vector3.ZERO
var IsAttakPlayer: bool = false

func _ready():
	createTargetPoint()

func _process(delta): 
	velocity = Vector3.ZERO
	
	if roundVector(targetPoint) == roundVector(global_position):
		createTargetPoint()
	
	print(str(targetPoint) + " " + str(global_transform.origin))
	velocity = (targetPoint - global_transform.origin).normalized() * 2
	look_at(targetPoint)
	
	move_and_slide()

func createTargetPoint():
	if target != null :
		IsAttakPlayer = !IsAttakPlayer
		
	if IsAttakPlayer:
		targetPoint = target.global_transform.origin
	else:
		targetPoint = global_position + Vector3(randi_range(-roundInt, roundInt), randi_range(-roundInt, roundInt), randi_range(-roundInt, roundInt))

func roundVector(vector : Vector3):
	return Vector3(roundi(vector.x), roundi(vector.y), roundi(vector.z))

func _on_area_3d_body_entered(body):
	if body is Player:
		state = ALERT
		target = body

func _on_area_3d_body_exited(body):
	if body is Player:
		sleep()
		IsAttakPlayer = false
