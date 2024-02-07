extends BaseItem
class_name ItemProparti

enum Propartis {
	HEAL,
	ARMOR,
	DAMEGA,
	SPIN,
	JUMP_COUNT
}

# type proparti
@export var proparti_enum_export : Propartis
var proparti_enum : Propartis

# proparti count
@export var count_proparti_export : int
var count_proparti

func _ready():
	ready()
	proparti_enum = proparti_enum_export
	count_proparti = count_proparti_export

func proparti(target : Player):
	target.getProparti(proparti_enum, count_proparti)
