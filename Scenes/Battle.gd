extends Node

@export var enemyScene : PackedScene
@export var battleUI : Node

@onready var TurnOrder = $TurnOrder
@onready var timer = $Timer

var partyList : Array[Node]
var defeatedParty : Array[Node]
var enemyList : Array[Node]
var defeatedEnemies : Array[Node]
var currentBattler : Node = null
var turnCount = 0

signal initialized

func initialize(party, enemies):
	#Create battlers for each member of the party and enemy
	#Populate the turn order
	
	for member in party:
		TurnOrder.addTurn(member)
		partyList.append(member)
		member.dead.connect(battlerDead)
	
	for enemy in enemies:
		var newBattler = enemyScene.instantiate()
		TurnOrder.add_child(newBattler)
		newBattler.targets = partyList
		TurnOrder.addTurn(newBattler)
		newBattler.initialize(enemy)
		enemyList.append(newBattler)
		newBattler.dead.connect(battlerDead)
	
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
	
	#When battle is over, emit a signal back to main
	if partyList.is_empty():
		#For now, just reboot the scene
		print("Game over")
		
	if enemyList.is_empty():
		#Tally XP for each enemy defeated
		#Abilities should have already tallied their own XP (?)
		#Delete the entity from the map
		print("You won!")

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

func battlerDead(battler : Node):
	print(battler, " is dead")
	var partyAlive = false
	var enemyAlive = false
	
	#Remove the battler from the turn order
	TurnOrder.removeBattler(battler)
	
	#Add the battler to the proper defeated list and remove it from its original list
	if battler in partyList:
		defeatedParty.append(battler)
		partyList.erase(battler)
	else:
		#If it's an enemy, remove its health bar(?)
		#Disconnect the enemy's button so that it can't be targeted
		battleUI.removeEnemy(battler)
		defeatedEnemies.append(battler)
		enemyList.erase(battler)
	pass
