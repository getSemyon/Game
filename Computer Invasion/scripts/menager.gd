extends Resource
class_name Menager

const URL : String = "user://PlayerData.tres"
@export var scene = preload("res://scen/testScen.tscn")

func save():
	ResourceSaver.save(self, URL);
	print("save")
	
func lode():
	if ResourceLoader.exists(URL):
		return load(URL)
