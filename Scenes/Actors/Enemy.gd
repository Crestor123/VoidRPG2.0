extends Node2D



#A string pointing to a resource file containing enemy data
@export var data : String

@onready var sprite = $Sprite2D
@onready var abilities = $AbilityComponent
@onready var stats = $StatComponent
@onready var healthBar = $HealthBar

var isActive = false
var resource : Resource

func initialize(data : Resource = null):
	if data != null:
		print("Resource for ", data.name, " given")
		resource = data
		stats.initialize(resource)
		abilities.initialize(resource.abilities)
	pass
	
func startTurn():
	#Called at the beginning of the battler's turn
	print(self, "is active.")
	pass

func chooseAbility():
	pass

func chooseTarget():
	pass
	
func useAbility():
	pass
	
func takeDamage():
	pass
	
func addBuff():
	pass
	
func die():
	pass
