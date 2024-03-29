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

var targets = [Node]
var allies = [Node]

func initialize(setResource : Resource = null):
	if setResource != null:
		print("Resource for ", setResource.name, " given")
		resource = setResource
		enemyName = resource.name
		stats.initialize(resource)
		stats.healthZero.connect(die)
		abilities.initialize(resource.abilities)
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
	if ability.target != "self":
		return targets[0]
	pass
	
func die():
	#print(self, " is dead")
	alive = false
	if isActive:
		turnFinished.emit()
	dead.emit(self)
	pass
