extends Node

@onready var Buffs = $Buffs

signal healthZero

var stats = {
	"health": 0, 
	"mana": 0, 
	"strength": 0, 
	"dexterity": 0, 
	"constitution": 0, 
	"intelligence": 0,
	"wisdom": 0,
	"charisma": 0
}

#Holds temporary values applied to stats
#As well as current health and mana
var tempStats = {
	"health": 0, 
	"mana": 0, 
	"strength": 0, 
	"dexterity": 0, 
	"constitution": 0, 
	"intelligence": 0,
	"wisdom": 0,
	"charisma": 0
}

var resistances = {
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

func initialize(resource = null):
	var data = resource
	if data != null:
		stats.health = data.health
		tempStats.health = data.health
		stats.mana = data.mana
		stats.strength = data.strength
		stats.dexterity = data.dexterity
		stats.constitution = data.constitution
		stats.intelligence = data.intelligence
		stats.wisdom = data.wisdom
		stats.charisma = data.charisma
		
		for item in resistances:
			resistances[item] = data.resistances[item]
			
func takeDamage(value, type):
	#print("initial damage: ", value)
	#print("resistance: ", resistances[type])
	var damageReduction = (float(resistances[type])) / 100
	#print("damage reduction: ", damageReduction)
	#value -= floor(value * float((100 - resistances[type]) / 100))
	value -= floor(damageReduction * value)
	#print("Taking ", value, " damage of ", type, " type")
	tempStats.health -= value
	print(tempStats.health, " left")
	if tempStats.health <= 0:
		tempStats.health = 0
		healthZero.emit()
	
	get_parent().updateHealthBar.emit(100 * (tempStats.health / stats.health))
	pass
	
func addBuff():
	pass

func getStat(stat : String):
	if stat in stats:
		return stats[stat] + tempStats[stat]
