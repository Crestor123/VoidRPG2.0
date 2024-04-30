extends Node

@export var buffObject : PackedScene

@export var parent : Node
@export var equipment : Node

signal healthZero

var level : int = 1

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

var tempResistances = {
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
	parent = get_parent()
	var data = resource
	if data != null:
		stats.health = data.health
		tempStats.health = data.health
		level = data.level
		stats.mana = data.mana
		stats.strength = data.strength
		stats.dexterity = data.dexterity
		stats.constitution = data.constitution
		stats.intelligence = data.intelligence
		stats.wisdom = data.wisdom
		stats.charisma = data.charisma
		
		for item in resistances:
			resistances[item] = data.resistances[item]
			
func takeDamage(value : int , type : String):
	#print("initial damage: ", value)
	#print("resistance: ", resistances[type])
	var damageReduction = (float(getResistance(type))) / 100
	#print("damage reduction: ", damageReduction)
	#value -= floor(value * float((100 - resistances[type]) / 100))
	if value > 0:
		value -= floor(damageReduction * value)
		value -= getStat("constitution")
		if value < 0: value = 0
	
	#print("Taking ", value, " damage of ", type, " type")
	tempStats.health -= value
	if tempStats.health > stats.health:
		tempStats.health = stats.health
	print(tempStats.health, " left")
	if tempStats.health <= 0:
		tempStats.health = 0
		healthZero.emit()
	
	parent.updateHealthBar.emit(getHealthPercent())
	pass
	
func addBuff(source : String, mainStat : String, value : int, turns : int, element : String):
	var newBuff = buffObject.instantiate()
	add_child(newBuff)
	
	newBuff.initialize(source, mainStat, value, turns, element)
	pass
	
func tickBuffs():
	print(get_children())
	for item in get_children():
		item.tick()
	pass

func getHealthPercent() -> float:
	return 100 * (float(getStat("health")) / float(getStat("maxhealth")))

func getStat(stat : String) -> int:
	var result : int = 0
	if stat in stats || stat == "maxhealth" || stat == "maxmana":
		if stat == "health": result = tempStats["health"]
		elif stat == "maxhealth": 
			result = stats["health"]
			if equipment: result += equipment.equipStats["health"]
		elif stat == "mana": result = tempStats["mana"]
		elif stat == "maxmana": 
			result = stats["mana"]
			if equipment: result += equipment.equipStats["health"]
		else:
			result = stats[stat] + tempStats[stat]
			if equipment: result += equipment.equipStats[stat]
	return result

func getResistance(resistance : String) -> int:
	var result : int = 0
	if resistance in resistances:
		result = resistances[resistance] + tempResistances[resistance]
		if equipment:
			result += equipment.equipResistances[resistance]
	return result
