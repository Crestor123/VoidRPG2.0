extends Node

@export var enemyScene : PackedScene
@export var battleUI : Node

@onready var TurnOrder = $TurnOrder
@onready var timer = $Timer

var partyList : Array[Node]
var enemyList : Array[Node]
var currentBattler : Node = null
var turnCount = 0

signal initialized

func initialize(party, enemies):
	#Create battlers for each member of the party and enemy
	#Populate the turn order
	
	for member in party:
		TurnOrder.addTurn(member)
		partyList.append(member)
	
	for enemy in enemies:
		var newBattler = enemyScene.instantiate()
		TurnOrder.add_child(newBattler)
		newBattler.targets = partyList
		TurnOrder.addTurn(newBattler)
		newBattler.initialize(enemy)
		enemyList.append(newBattler)
	
	for enemy in enemyList:
		enemy.allies = enemyList
	
	battleUI.updateEnemies(enemyList)
	#Small delay to allow UI to initialize
	timer.start()
	await timer.timeout
	battleUI.chooseAbility.connect(useAbility)
	TurnOrder.sortTurn()
	
	return
	
func battle():
	while !partyList.is_empty() and !enemyList.is_empty():
		currentBattler = TurnOrder.nextBattler()
		startTurn(currentBattler)
		if currentBattler in partyList:
			await battleUI.chooseAbility
	
		if currentBattler in enemyList:
			await currentBattler.turnFinished

		timer.wait_time = 1
		timer.start()
		await timer.timeout
	
		print("Ending turn")
		battleUI.hideAbilities()
		turnCount += 1
		pass

func useAbility(ability, target):
	print(currentBattler, " using ", ability, " on ", target)
	currentBattler.abilities.useAbility(ability, target)
	pass

func startTurn(battler : Node):
	if battler in partyList:
		#The battler is a party member, initialize the battle UI
		battleUI.updateAbilities(battler.abilities)
		#battleUI.cursor.initialize(enemyList)
	battler.startTurn(turnCount)
	pass

func endTurn():
	pass

func battlerDead():
	pass
