extends Node

@export var source : String
@export_enum ("health", "mana", "strength", "dexterity", "constitution", 
	"intelligence", "wisdom", "charisma" ) var mainStat : String
#Positive values denote buffs, negative values are debuffs
@export var value : int
@export var turns : int

@export_enum ("fire", "light", "heat", "electricity", "earth", "metal", 
	"crystal", "wood", "air", "sound", "motion", "void", "water", "cold",
	"acid", "darkness", "mind", "soul", "flesh", "time") var element : String
	
var target : Node = null
	
func initialize(source : String, mainStat : String, value : int, turns : int, element : String):
	self.source = source
	self.mainStat = mainStat
	self.value = value
	self.turns = turns
	self.element = element
	target = get_parent()
	
	if mainStat != "health" && mainStat != "mana":
		print("adding ", value, " to ", mainStat)
		target.tempStats[mainStat] += value

func tick():
	#Evaluate the effects of the buff each turn
	if mainStat == "health":
		target.tempStats.health += value
	if mainStat == "mana":
		target.tempStats.mana += value
		
	turns -= 1
	if turns == 0:
		expire()
	pass
	
func expire():
	#When the buff's turn counter reaches zero, remove the buff's effects
	if mainStat != "health" or mainStat != "mana":
		target.tempStats[mainStat] -= value
		
	queue_free()
	pass
