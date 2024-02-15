extends Node3D

@onready var UILayer = $UILayer
@onready var Player = $Player
@onready var Battle = $Battle
@onready var Party = $PartyMembers
@onready var Grid = $GridMap
@onready var Entities = $Entities
@onready var AbilityData = $AbilityDatabase

enum {MOVEMENT, BATTLE, HEALTH, EXPERIENCE}
var currentUILayer : Node = null
var movementUI : Node = null
var battleUI : Node = null
var healthUI : Node = null
var experienceUI : Node = null

var interactingEntity : Node = null

func _ready():
	for item in Entities.get_children():
		item.interacting.connect(entityInteract)
	
	for member in Party.get_children():
		member.initialize()
	
	Battle.victory.connect(winBattle)
	
	connectUI()
	pass

func connectUI():
	movementUI = UILayer.get_child(0)
	battleUI = UILayer.get_child(1)
	healthUI = UILayer.get_child(2)
	experienceUI = UILayer.get_child(3)
	
	swapUI(movementUI)
	UILayer.get_child(MOVEMENT).buttonPressed.connect(Player.move)
	UILayer.get_child(MOVEMENT).buttonPressed.connect(buttonPressed)
	
	healthUI.initialize(Party.get_children())
	pass
	
func buttonPressed(button : String):
	print(button, " pressed")
	pass

func entityInteract(ID, type, data):
	print(type, " ", data)
	interactingEntity = ID
	
	if type == "enemy":
		#Start the battle using the enemy data
		enterBattle(data)
	pass

func enterBattle(enemyData):
	#Swap out UI
	swapUI(battleUI)
	await Battle.initialize(Party.get_children(), enemyData)
	#Battle.victory.connect(winBattle)
	Battle.battle()
	pass

func winBattle(defeatedEnemies):
	#Remove entity from field
	interactingEntity.queue_free()
	battleUI.clear()
	swapUI(experienceUI)
	
	#Calculate the experience gained
	var xp = 0
	for enemy in defeatedEnemies:
		xp += enemy.stats.level
	#Add the experience to each party member
	for item in Party.get_children():
		item.addXP(xp)
		item.knowledge.checkAbilityData(AbilityData.abilityData)
	#Show the experience bar(s)
	experienceUI.initialize(Party.get_children(), xp)
	await experienceUI.continueButton
	
	for item in defeatedEnemies:
		item.queue_free()
	
	swapUI(movementUI)
	pass
	
func swapUI(layer : Node):
	for item in UILayer.get_children():
		if item == healthUI:
			continue
		item.visible = false
	#currentUILayer = UILayer.get_child(layer)
	currentUILayer = layer
	currentUILayer.visible = true
