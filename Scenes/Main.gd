extends Node3D

@onready var UILayer = $UILayer
@onready var Player = $Player
@onready var Battle = $Battle
@onready var Party = $PartyMembers
@onready var Grid = $GridMap
@onready var Entities = $Entities

enum {MOVEMENT, BATTLE}
var currentUILayer : Node = null

func _ready():
	for item in Entities.get_children():
		item.interacting.connect(entityInteract)
	connectUI()
	
	for member in Party.get_children():
		member.initialize()
	pass

func connectUI():
	swapUI(MOVEMENT)
	UILayer.get_child(0).buttonPressed.connect(Player.move)
	UILayer.get_child(0).buttonPressed.connect(buttonPressed)
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
	swapUI(BATTLE)
	Battle.initialize(Party.get_children(), enemyData)
	Battle.battle()
	pass

func swapUI(layer : int):
	for item in UILayer.get_children():
		item.visible = false
	currentUILayer = UILayer.get_child(layer)
	currentUILayer.visible = true
