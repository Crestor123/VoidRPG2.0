extends Node3D

@onready var UILayer = $UILayer
@onready var UIOverlay = $UIOverlay
@onready var Player = $Player
@onready var Battle = $Battle
@onready var Party = $PartyMembers
@onready var Inventory = $InventoryComponent
@onready var Grid = $GridMap
@onready var Entities = $Entities
@onready var AbilityData = $AbilityDatabase

var currentUILayer : Node = null
var prevUILayer : Node = null
var currentOverlay : Node = null

var interactingEntity : Node = null

func _ready():
	for item in Entities.get_children():
		item.interacting.connect(entityInteract)
	
	for member in Party.get_children():
		member.inventory = Inventory
		member.initialize()
	
	for item in UILayer.get_children():
		if item == UILayer.healthUI: continue
		item.visible = false
		
	for item in UIOverlay.get_children():
		item.visible = false
	
	Battle.victory.connect(winBattle)
	
	connectUI()
	pass

func connectUI():
	swapUI(UILayer.movementUI)
	UILayer.movementUI.movementButtonPressed.connect(Player.move)
	UILayer.movementUI.buttonPressed.connect(buttonPressed)
	
	UILayer.inventoryUI.buttonPressed.connect(buttonPressed)
	UILayer.inventoryUI.use.connect(partySelector)
	
	UILayer.healthUI.initialize(Party.get_children())
	pass
	
func buttonPressed(button : String):
	print(button, " pressed")
	if  button == "inventory":
		#Open the inventory
		swapUI(UILayer.inventoryUI)
		UILayer.inventoryUI.fillItems(Party.get_child(0).inventory)
	if button == "back":
		if prevUILayer != null: swapUI(prevUILayer)
		else: swapUI(UILayer.movementUI)
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
	swapUI(UILayer.battleUI)
	await Battle.initialize(Party.get_children(), enemyData)
	#Battle.victory.connect(winBattle)
	Battle.battle()
	pass

func winBattle(defeatedEnemies):
	#Remove entity from field
	interactingEntity.queue_free()
	UILayer.battleUI.clear()
	swapUI(UILayer.experienceUI)
	
	#Calculate the experience gained
	var xp = 0
	for enemy in defeatedEnemies:
		xp += enemy.stats.level
	#Add the experience to each party member
	for item in Party.get_children():
		item.addXP(xp)
		item.knowledge.checkAbilityData(AbilityData.abilityData)
	#Show the experience bar(s)
	UILayer.experienceUI.initialize(Party.get_children(), xp)
	await UILayer.experienceUI.continueButton
	
	for item in defeatedEnemies:
		item.queue_free()
	
	swapUI(UILayer.movementUI)
	pass
	
func swapUI(layer : Node):
	prevUILayer = currentUILayer
	for item in UILayer.get_children():
		if item == UILayer.healthUI:
			continue
		item.visible = false
	#currentUILayer = UILayer.get_child(layer)
	currentUILayer = layer
	currentUILayer.visible = true

func partySelector(caller : Node):
	UIOverlay.partySelectorUI.initialize(Party.get_children(), caller)
	UIOverlay.partySelectorUI.visible = true
	pass
