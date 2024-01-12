extends Control

@export var abilityObject : PackedScene
@export var enemyHealthObject : PackedScene
@export var enemyButton : PackedScene

@onready var cursor = $Cursor
@onready var abilityContainer = $ColorRect/MarginContainer/ScrollContainer/AbilityContainer
@onready var healthBarContainer = $ColorRect2/HealthBarContainer
@onready var buttonContainer = $ButtonContainer

signal chooseAbility(data, target)

func updateEnemies(enemyList : Array[Node]):
	#Clear out any existing health bars
	cursor.visible = false
	for item in healthBarContainer.get_children():
		item.queue_free()
	for item in buttonContainer.get_children():
		item.queue_free()
	
	#Create a new health bar for each enemy
	for item in enemyList:
		var newHealthBar = enemyHealthObject.instantiate()
		healthBarContainer.add_child(newHealthBar)
		pass
		
	#If there is more than one enemy, show the cursor
	#Create buttons to move the cursor
	if enemyList.size() > 1:
		cursor.visible = true
		cursor.initialize(healthBarContainer.get_children())
		
		for item in enemyList:
			var newButton = enemyButton.instantiate()
			buttonContainer.add_child(newButton)
			newButton.data = item.get_index()
			newButton.buttonPressed.connect(cursorButton)
		

func updateAbilities(abilityComponent : Node):
	#Clear out the ability container
	for item in abilityContainer.get_children():
		item.queue_free()
	
	#Connect the ability signal to the party member
	chooseAbility.connect(abilityComponent.useAbility)
	
	#Populate the list of abilities with the abilities given
	for item in abilityComponent.get_children():
		print("creating button for ", item.abilityName)
		var ability = abilityObject.instantiate()
		abilityContainer.add_child(ability)
		ability.buttonPressed.connect(abilityTransmit)
		ability.initialize(item)
	pass

func abilityTransmit(ability : Node):
	chooseAbility.emit(ability, null)
	pass

func cursorButton(buttonData : int):
	cursor.moveCursor(healthBarContainer.get_child(buttonData))
	pass
