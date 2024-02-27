extends Resource

class_name Item

@export var name : String
@export_multiline var description : String
@export var icon : Texture2D

@export var cost : int

@export_enum ("consumable", "equipment") var type : String

@export_enum ("none", "head", "body", "legs", "feet", "ring", "weapon") var slot : String

@export_enum ("health", "mana", "strength", "dexterity", "constitution", 
	"intelligence", "wisdom", "charisma" ) var targetStat : String
	
@export_enum ("fire", "light", "heat", "electricity", "earth", "metal", 
	"crystal", "wood", "air", "sound", "motion", "void", "water", "cold",
	"acid", "darkness", "mind", "soul", "flesh", "time") var element : String
	
@export var bonus : int

@export var additionalEffects : Dictionary
