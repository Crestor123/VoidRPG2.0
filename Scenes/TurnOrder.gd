extends Node

var turnOrder = []
var currentBattler : int = -1

func addTurn(battler : Node):
	#Adds a node to the turn order
	turnOrder.append(battler)

func sortTurn():
	#Sorts turn order according to speed
	turnOrder.sort_custom(sort)
	print(turnOrder)
	pass

func nextBattler():
	currentBattler += 1
	if currentBattler >= turnOrder.size():
		currentBattler = 0
	return turnOrder[currentBattler]
	
	pass
	
func clear():
	pass

static func sort(a : Node, b : Node):
	#print(a, a.stats.getStat("dexterity"))
	#print(b, b.stats.getStat("dexterity"))
	return a.stats.getStat("dexterity") > b.stats.getStat("dexterity")
