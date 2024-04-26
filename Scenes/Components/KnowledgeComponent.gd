extends Node

@export var parent : Node

var knowledge = {
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

func initialize():
	parent = get_parent()

func addKnowledge(type : String, amount : int):
	knowledge[type] += amount
	
func checkAbilityData(abilityData : Dictionary):
	#Check each ability in the database to see if the knowledge prerequisites have been met
	var knownAbilities = parent.abilities.get_children()
	var knowledgeKeys = knowledge.keys()
	var skip = false
	var learn = true
	
	for item in abilityData:
		skip = false
		learn = true
		#If the party member already has the ability, skip it
		for knownAbility in knownAbilities:
			if abilityData[item]["name"] == knownAbility.abilityName: skip = true
		if skip == true: continue
		
		#Check the prerequisites
		for key in abilityData[item]["prerequisites"].keys():
			if knowledge.has(key):
				if knowledge[key] < abilityData[item]["prerequisites"]:
					#The party member doesn't qualify to learn the ability
					learn  = false
					
		if learn == true:
			#Learn the ability
			parent.abilities.addAbility(item)
