extends BaseItem
class_name WeponItem

enum wepons {
	NonWepon,
	Wepon1,
	Wepon2
}

@export var wepon_export : wepons
var wepon : wepons

func _ready():
	self._ready
	wepon = wepon_export

func proparti(target : Player):
	target.getWepon(wepon)
