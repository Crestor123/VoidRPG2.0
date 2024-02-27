extends Node

@export var data : Resource

@export var itemName : String
@export_multiline var description : String
@export var icon : Texture2D

@export var cost : int

@export_enum ("consumable", "equipment") var type : String

#If consumable, this is left blank
@export_enum ("head", "body", "legs", "feet", "ring", "weapon") var slot : String

@export_enum ("health", "mana", "strength", "dexterity", "constitution", 
	"intelligence", "wisdom", "charisma" ) var targetStat : String
	
@export_enum ("fire", "light", "heat", "electricity", "earth", "metal", 
	"crystal", "wood", "air", "sound", "motion", "void", "water", "cold",
	"acid", "darkness", "mind", "soul", "flesh", "time") var element : String
	
@export var bonus : int

@export var additionalEffects : Dictionary

func initialize():
	if data != null:
		itemName = data.name
		description = data.description
		icon = data.icon
		cost = data.cost
		type = data.type
		slot = data.slot
		targetStat = data.targetStat
		element = data.element
		bonus = data.bonus
		additionalEffects = data.additionalEffects
