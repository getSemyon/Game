extends BaseDialogueTestScene
@onready var animation_player = $AnimationPlayer
@onready var example_balloon = $ExampleBalloon

func _ready():
	DialogeState.started.connect(start)
	DialogeState.ended.connect(end)
	
	if DialogeState.text == "" or DialogeState.text == null: 
		example_balloon.start(resource, "start_game")
	else:
		example_balloon.start(resource, "information")
	
func start():
	animation_player.play("start")

func end():
	animation_player.play("end")

func delete():
	queue_free()
