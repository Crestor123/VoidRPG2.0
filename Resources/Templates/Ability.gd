extends Resource

class_name Ability

@export var name : String
@export var description : String
@export var icon : Texture2D

@export var type : String
@export var target : String

@export_enum ("health", "mana", "strength", "dexterity", "constitution", 
	"intelligence", "wisdom", "charisma" ) var mainStat : String
@export_enum ("health", "mana", "strength", "dexterity", "constitution", 
	"intelligence", "wisdom", "charisma" ) var targetStat : String
	
@export var cost : int = 0
@export var baseDamage : int
@export var multiplier : float
@export var turns : int = 0 

@export_enum ("fire", "light", "heat", "electricity", "earth", "metal", 
	"crystal", "wood", "air", "sound", "motion", "void", "water", "cold",
	"acid", "darkness", "mind", "soul", "flesh", "time") var element : String

@export var prerequisites : Dictionary

@export var additionalEffects : Array[Script]
