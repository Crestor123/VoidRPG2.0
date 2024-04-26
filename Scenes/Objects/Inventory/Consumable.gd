extends ItemNode

class_name ConsumableNode

@export_enum ("health", "mana", "strength", "dexterity", "constitution", 
	"intelligence", "wisdom", "charisma" ) var targetStat : String
	
@export_enum ("fire", "light", "heat", "electricity", "earth", "metal", 
	"crystal", "wood", "air", "sound", "motion", "void", "water", "cold",
	"acid", "darkness", "mind", "soul", "flesh", "time") var element : String
	
@export var bonus : int

@export var quantity : int = 1

func initialize():
	if data != null:
		targetStat = data.targetStat
		element = data.element
		bonus = data.bonus
		quantity = data.quantity
	super.initialize()
