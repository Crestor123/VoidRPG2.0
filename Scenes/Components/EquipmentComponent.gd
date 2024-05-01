extends Node

@export var inventory : Node = null

#Slots point to equipmentNodes that are children of this node
var slots = { 
	"head": null, 
	"body": null, 
	"legs": null, 
	"feet": null, 
	"lring": null, 
	"rring": null, 
	"weapon": null}

#Bonuses from equipment are recorded here
var equipStats = {
	"health": 0, 
	"mana": 0, 
	"strength": 0, 
	"dexterity": 0, 
	"constitution": 0, 
	"intelligence": 0,
	"wisdom": 0,
	"charisma": 0
}

var equipResistances = {
	"fire": 0,
	"light": 0,
	"heat": 0,
	"electricity": 0,
	"earth": 0,
	"metal": 0,
	"crystal": 0,
	"wood": 0,
	"air": 0,
	"sound": 0,
	"motion": 0,
	"void": 0,
	"water": 0,
	"cold": 0,
	"acid": 0,
	"darkness": 0,
	"mind": 0,
	"soul": 0,
	"flesh": 0,
	"time": 0
}

func equip(equipment : EquipmentNode, slot : String = "") -> bool:
	if inventory == null: return false
	if !slot in slots: return false
	
	var equipped = false
	
	inventory.transferItem(equipment, self)
	if slots[slot] != null:
		slots[slot].reparent(inventory)
		slots[slot] = null
	if slots[slot] == null:
		slots[slot] = equipment
		equipment.currentSlot = slot
		equipped = true
	
	updateStats()
	
	return equipped
	pass
	
func updateStats():
	for stat in equipStats:
		equipStats[stat] = 0
	for res in equipResistances:
		equipResistances[res] = 0
	
	for item in get_children():
		for stat in item.bonuses:
			equipStats[stat] += item.bonuses[stat]
		for res in equipResistances:
			equipResistances[res] += item.resistances[res]
	print("Updated equipment")
	
func unequip(equipment : EquipmentNode) -> bool:
	if inventory == null: return false
	var unequipped = false
	print("Unequipping ", equipment)
	for slot in slots:
		if slots[slot] == equipment:
			equipment.reparent(inventory)
			slots[slot] = null
			unequipped = true
	return unequipped
	pass
