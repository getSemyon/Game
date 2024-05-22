extends Node3D
class_name BaseItem

@export_dir var item_rotate
@onready var rotate_item = $Rotate_Item

func _ready():
	ready()

func ready():
	var object = load(item_rotate).instantiate()
	rotate_item.add_child(object)
	
	$AnimationPlayer.play("idel_item_animation")

func proparti(target : Player):
	pass

func get_data():
	return name

func _on_area_3d_area_entered(area):
	proparti(area.get_parent())
	queue_free()
