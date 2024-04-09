extends Node3D

@onready var marker_3d = $Marker3D

@export var adjacent_target: Node3D
@export var opposite_target: Node3D

func _ready():
	marker_3d.adjacent_target = adjacent_target.get_child(1)
	marker_3d.opposite_target = opposite_target.get_child(1)
