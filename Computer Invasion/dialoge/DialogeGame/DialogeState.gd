extends Node
class_name dialoge_state

signal started
signal ended

var text : String

func start():
	started.emit()

func end():
	ended.emit()
