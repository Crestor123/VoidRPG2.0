extends ItemNode

class_name EquipmentNode

@export_enum ("head", "body", "legs", "feet", "ring", "weapon") var slot : String

@export var bonuses = {
	"health": 0,
	"mana": 0,
	"strength": 0,
	"dexterity": 0,
	"constitution": 0,
	"intelligence": 0,
	"wisdom": 0,
	"charisma": 0
}

@export var resistances = {
	"fire": 0,
	"light": 0,
	"heat": 0,
	"electricity": 0,
	"earth": 0,
	"metal": 0,
	"crystal": 0,
	"wood": 0,
	"air": 0,
	"sound": 0,
	"motion": 0,
	"void": 0,
	"water": 0,
	"cold": 0,
	"acid": 0,
	"darkness": 0,
	"mind": 0,
	"soul": 0,
	"flesh": 0,
	"time": 0
}

var currentSlot : String = ""

func initialize():
	if data != null:
		slot = data.slot
		for item in data.bonuses:
			bonuses[item] = data.bonuses[item]
		for item in data.resistances:
			resistances[item] = data.resistances[item]
	super.initialize()
