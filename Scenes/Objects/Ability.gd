extends Node

@export var data : Resource

@export var abilityName : String
@export var description : String
@export var icon : Texture2D

@export var type : String
@export var target : String

@export_enum ("health", "mana", "strength", "dexterity", "constitution", 
	"intelligence", "wisdom", "charisma" ) var mainStat : String
@export_enum ("health", "mana", "strength", "dexterity", "constitution", 
	"intelligence", "wisdom", "charisma", "taunt" ) var targetStat : String
	
@export var cost : int = 0
@export var baseDamage : int
@export var multiplier : float
@export var turns : int = 0 

@export_enum ("fire", "light", "heat", "electricity", "earth", "metal", 
	"crystal", "wood", "air", "sound", "motion", "void", "water", "cold",
	"acid", "darkness", "mind", "soul", "flesh", "time") var element : String

@export var additionalEffects: Array

func initialize():
	if data != null:
		abilityName = data.name
		description = data.description
		icon = data.icon
		type = data.type
		target = data.target
		mainStat = data.mainStat
		targetStat = data.targetStat
		cost = data.cost
		baseDamage = data.baseDamage
		multiplier = data.multiplier
		turns = data.turns
		element = data.element
		additionalEffects = data.additionalEffects
		
		if type == "passive":
			if target == "self":
				if get_parent().parent.stats: get_parent().parent.stats.tempStats[targetStat] += baseDamage
			elif target == "party":
				for member in get_parent().parent.get_parent().get_children():
					if member.stats: member.stats.tempStats[targetStat] += baseDamage
		
		print("New ability ", abilityName, " created")
