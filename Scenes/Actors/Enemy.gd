extends Node2D



#A string pointing to a resource file containing enemy data
@export var data : String

@onready var abilities = $AbilityComponent
@onready var stats = $StatComponent
#@onready var healthBar = $HealthBar
@onready var timer = $Timer

signal updateHealthBar(percentage)
signal turnFinished
signal dead(data)

var enemyName : String

var isActive : bool = false
var alive : bool = true
var resource : Resource

var targets : Array[Node]
var aggro : Array[float]
var allies : Array[Node]

func initialize(setResource : Resource = null):
	
	if setResource != null:
		print("Resource for ", setResource.name, " given")
		resource = setResource
		enemyName = resource.name
		stats.initialize(resource)
		stats.healthZero.connect(die)
		abilities.initialize(resource.abilities)
	
	aggro.resize(targets.size())
	for i in range(targets.size()):
		#Set the aggro weights for each target
		#+1 aggro == +1% chance to attack target
		aggro[i] = float(100.0 / targets.size())
	pass
	
func startTurn(turnCount : int):
	#Called at the beginning of the battler's turn
	print(self, "is active.")
	stats.tickBuffs()
	var ability = chooseAbility(turnCount)
	var target = chooseTarget(ability)
	
	timer.start()
	await timer.timeout
	
	abilities.useAbility(ability, target)

	turnFinished.emit()
	pass

func chooseAbility(turnCount : int) -> Node:
	#Choose one of the available abilities based on turn count
	return (abilities.get_child((turnCount % abilities.get_child_count())))

func chooseTarget(ability : Node):
	#Using the aggro array, select a target
	if ability.target == "self": return self
	if targets.size() == 1: return targets[0]
	
	var rand = randf_range(1, 100)
	var acc = 0
	for i in range(aggro.size()):
		acc += aggro[i]
		if acc >= rand:
			return targets[i]
	
	pass

func updateAggro(target : Node, value : int):
	for i in range(targets.size()):
		if targets[i] == target:
			aggro[i] += value
		else:
			aggro[i] -= (value / (targets.size() - 1)) 
	pass

func die():
	#print(self, " is dead")
	alive = false
	if isActive:
		turnFinished.emit()
	dead.emit(self)
	pass
