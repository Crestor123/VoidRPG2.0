extends Item

class_name Equipment

@export_enum ("none", "head", "body", "legs", "feet", "ring", "weapon") var slot : String

@export var bonuses = {
	"health": 0,
	"mana": 0,
	"stength": 0,
	"dexterity": 0,
	"constitution": 0,
	"intelligence": 0,
	"wisdom": 0,
	"charisma": 0
}
