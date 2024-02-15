extends Control

@export var abilityObject : PackedScene
@export var enemyHealthObject : PackedScene
@export var enemyButton : PackedScene

@onready var cursor = $Cursor
@onready var abilityContainer = $ColorRect/MarginContainer/ScrollContainer/AbilityContainer
@onready var healthBarContainer = $ColorRect2/HealthBarContainer
@onready var buttonContainer = $ButtonContainer

#Pointer to enemyList
var enemies = []
var selectedEnemy : int = 0

signal chooseAbility(ability, target)

func updateEnemies(enemyList : Array[Node]):
	enemies = enemyList
	#Clear out any existing health bars
	cursor.visible = false
	for item in healthBarContainer.get_children():
		item.queue_free()
	for item in buttonContainer.get_children():
		item.queue_free()
	
	#Create a new health bar for each enemy
	for item in enemies:
		var newHealthBar = enemyHealthObject.instantiate()
		healthBarContainer.add_child(newHealthBar)
		newHealthBar.initialize(item.enemyName, 100)
		item.updateHealthBar.connect(newHealthBar.healthBar.setBar)
		pass
		
	#If there is more than one enemy, show the cursor
	#Create buttons to move the cursor
	#Initialize an data value that is passed by the button when pressed
	if enemies.size() > 1:
		#cursor.visible = true
		
		for item in enemies:
			var newButton = enemyButton.instantiate()
			buttonContainer.add_child(newButton)
			newButton.data = item.get_index()
			#newButton.target = item
			newButton.buttonPressed.connect(cursorButton)
			
		#cursor.initialize(healthBarContainer.get_children())
		#cursorButton(0)
		
func updateAbilities(abilityComponent : Node):
	#Clear out the ability container
	abilityContainer.hide()
	for item in abilityContainer.get_children():
		item.queue_free()
	
	#Connect the ability signal to the party member
	#chooseAbility.connect(abilityComponent.useAbility)
	
	#Populate the list of abilities with the abilities given
	for item in abilityComponent.get_children():
		print("creating button for ", item.abilityName)
		var ability = abilityObject.instantiate()
		abilityContainer.add_child(ability)
		ability.buttonPressed.connect(abilityTransmit)
		ability.initialize(item)
	pass
	abilityContainer.show()
	
	#If there is more than one enemy, show the target cursor
	cursor.visible = true
	if !cursor.currentTarget:
		cursorButton(0)

func removeEnemy(enemy : Node):
	#Remove the enemy's health bar and button
	cursor.visible = false
	
	print(enemy)
	print(enemies)
	var index = enemies.find(enemy)
	print(index)
	healthBarContainer.get_child(index).queue_free()
	if buttonContainer.get_child_count() > 0:
		buttonContainer.get_child(index).queue_free()

func hideAbilities():
	abilityContainer.hide()
	cursor.hide()
	for item in abilityContainer.get_children():
		item.queue_free()

func abilityTransmit(ability : Node):
	chooseAbility.emit(ability, enemies[selectedEnemy])
	pass

func cursorButton(buttonData : int):
	selectedEnemy = buttonData
	cursor.moveCursor(healthBarContainer.get_child(buttonData))
	pass

func clear():
	for item in abilityContainer.get_children():
		item.queue_free()
	for item in buttonContainer.get_children():
		item.queue_free()
	pass
