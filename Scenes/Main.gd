extends Node3D

@onready var UILayer = $UILayer
@onready var Player = $Player
@onready var Battle = $Battle
@onready var Party = $PartyMembers
@onready var Grid = $GridMap
@onready var Entities = $Entities

enum {MOVEMENT, BATTLE, HEALTH}
var currentUILayer : Node = null
var movementUI : Node = null
var battleUI : Node = null
var healthUI : Node = null

func _ready():
	for item in Entities.get_children():
		item.interacting.connect(entityInteract)
	
	for member in Party.get_children():
		member.initialize()
		
	connectUI()
	pass

func connectUI():
	movementUI = UILayer.get_child(0)
	battleUI = UILayer.get_child(1)
	healthUI = UILayer.get_child(2)
	
	swapUI(movementUI)
	UILayer.get_child(MOVEMENT).buttonPressed.connect(Player.move)
	UILayer.get_child(MOVEMENT).buttonPressed.connect(buttonPressed)
	
	healthUI.initialize(Party.get_children())
	pass
	
func buttonPressed(button : String):
	print(button, " pressed")
	pass

func entityInteract(type, data):
	print(type, " ", data)
	
	if type == "enemy":
		#Start the battle using the enemy data
		enterBattle(data)
	pass

func enterBattle(enemyData):
	#Swap out UI
	swapUI(battleUI)
	await Battle.initialize(Party.get_children(), enemyData)
	Battle.battle()
	pass

func swapUI(layer : Node):
	for item in UILayer.get_children():
		if item == healthUI:
			continue
		item.visible = false
	#currentUILayer = UILayer.get_child(layer)
	currentUILayer = layer
	currentUILayer.visible = true
