extends BaseItem
class_name WeponItem

const ResursWepon = preload("res://Resurs/Resurs_wepon.gd")

@export var wepon_export : WEPONS.wepons_name
var wepon : WEPONS.wepons_name

func _ready():
	ready()
	wepon = wepon_export

func proparti(target : Player):	
	target.getWepon(wepon)
	
