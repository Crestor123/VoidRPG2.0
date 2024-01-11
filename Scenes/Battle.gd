extends Node

@export var enemyScene: PackedScene

@onready var TurnOrder = $TurnOrder

var partyList : Array[Node]
var enemyList : Array[Node]
var battleUI : Node = null
var currentBattler : Node = null

func initialize(party, enemies, UI):
	#Create battlers for each member of the party and enemy
	#Populate the turn order
	battleUI = UI
	
	for member in party:
		TurnOrder.addTurn(member)
		partyList.append(member)
	
	for enemy in enemies:
		var newBattler = enemyScene.instantiate()
		TurnOrder.add_child(newBattler)
		TurnOrder.addTurn(newBattler)
		newBattler.initialize(enemy)
		enemyList.append(newBattler)
		
	TurnOrder.sortTurn()
	
func battle():
	currentBattler = TurnOrder.nextBattler()
	startTurn(currentBattler)
	pass

func startTurn(battler : Node):
	if battler in partyList:
		#The battler is a party member, initialize the battle UI
		battleUI.updateAbilities(battler.abilities)
		#battleUI.cursor.initialize(enemyList)
	battler.startTurn()
	pass

func endTurn():
	pass

func battlerDead():
	pass
