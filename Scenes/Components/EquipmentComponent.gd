extends Node

@export var inventory : Node = null

#Need to have slots that can be filled by appropriate equipment
var slots = { 
	"head": null, 
	"body": null, 
	"legs": null, 
	"feet": null, 
	"lring": null, 
	"rring": null, 
	"weapon": null}


func equip(equipment : EquipmentNode, slot : String = "") -> bool:
	if inventory == null: return false
	if !slot in slots: return false
	
	var equipped = false
	
	inventory.transferItem(equipment, self)
	if slots[slot] != null:
		inventory.transferItem(slots[slot], inventory)
		slots[slot] = null
	if slots[slot] == null:
		slots[slot] = equipment
		equipped = true
	
	return equipped
	pass
	
func unequip(equipment : EquipmentNode):
	pass
