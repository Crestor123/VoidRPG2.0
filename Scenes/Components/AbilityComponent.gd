extends Node

@export var abilityObject : PackedScene

@export var stats : Node
@export var parent : Node

func initialize(abilityList):
	parent = get_parent()
	for item in abilityList:
		var newAbility = abilityObject.instantiate()
		add_child(newAbility)
		newAbility.data = item
		newAbility.initialize()
	pass

func addAbility(abilityPath : String):
	var loadAbility = load(abilityPath)
	var newAbility = abilityObject.instantiate()
	add_child(newAbility)
	newAbility.data = loadAbility
	newAbility.initialize()

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
		target = parent
	if target == null:
		print("Error: no target for ability")
		return

	if parent.has_node("KnowledgeComponent"):
		parent.knowledge.addKnowledge(ability.element, 1)

	match ability.type:
		"attack":
			target.stats.takeDamage(damage, ability.element)
		"buff":
			target.stats.addBuff(parent, ability, damage)
		"debuff":
			target.stats.addBuff(parent, ability, -damage)
