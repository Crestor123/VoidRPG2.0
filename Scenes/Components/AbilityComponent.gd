extends Node

@export var abilityObject : PackedScene

@export var stats : Node

func initialize(abilityList):
	for item in abilityList:
		var newAbility = abilityObject.instantiate()
		add_child(newAbility)
		newAbility.data = item
		newAbility.initialize()
	pass

func useAbility(ability, target):
	if ability not in get_children():
		print("Error: no such ability")
		return
	
	var damage = 0

	#Add up base damage, the main stat value, and apply the multiplier
	damage = (ability.baseDamage + stats.getStat(ability.mainStat)) * ability.multiplier
	#Evaluate additional effects
	#Based on the type of ability, apply the result to the target(s)
	if ability.target == "self":
		print("targeting self")
	else:
		print("dealing ", damage, " damage to the target")
		if target: target.stats.takeDamage(damage, ability.element)
