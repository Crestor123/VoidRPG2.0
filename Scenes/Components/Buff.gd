extends Node

@export var source : Node
@export var ability : Node
@export_enum ("health", "mana", "strength", "dexterity", "constitution", 
	"intelligence", "wisdom", "charisma", "taunt" ) var mainStat : String
#Positive values denote buffs, negative values are debuffs
@export var value : int
@export var turns : int

@export_enum ("fire", "light", "heat", "electricity", "earth", "metal", 
	"crystal", "wood", "air", "sound", "motion", "void", "water", "cold",
	"acid", "darkness", "mind", "soul", "flesh", "time") var element : String
	
var target : Node = null
	
func initialize(source : Node, ability: Node, value : int):
	self.source = source
	self.ability = ability
	self.mainStat = ability.targetStat
	self.value = value
	self.turns = ability.turns
	self.element = ability.element
	target = get_parent()
	
	if mainStat == "taunt":
		target.parent.updateAggro(source, -value)
	
	elif mainStat != "health" && mainStat != "mana":
		print("adding ", value, " to ", mainStat)
		target.tempStats[mainStat] += value

func tick():
	#Evaluate the effects of the buff each turn
	if mainStat == "health":
		target.takeDamage(-value, element)
	if mainStat == "mana":
		target.tempStats.mana += value
		
	turns -= 1
	if turns == 0:
		expire()
	pass
	
func expire():
	#When the buff's turn counter reaches zero, remove the buff's effects
	if mainStat == "taunt":
		target.parent.updateAggro(source, value)
	elif mainStat != "health" and mainStat != "mana":
		target.tempStats[mainStat] -= value
		
	queue_free()
	pass
