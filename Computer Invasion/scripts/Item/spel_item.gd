extends BaseItem
class_name SpelItem

enum spels {
	none,
	spin
}

@export var spel_export : spels
var spel : spels

func _ready():
	self._ready
	spel = spel_export


