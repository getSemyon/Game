extends CharacterBody3D
class_name enemyHaracter

@export var heal : int
@export var damage : int
@export var speed : int

enum State {IDEL, ALERT, ATTACK, SHOOT, DEATH}
var state : State = State.IDEL
var isDead = false
var target : Player

func _attack():
	target._take_damege(damage)

func _shoot():
	pass

func _take_damege(dm : int):
	heal -= dm
	if heal <= 0 and state != State.DEATH:
		isDead = true
		_death()
		
func _death():
	state = State.DEATH
	queue_free()
