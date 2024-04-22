extends Node

class_name ItemNode

@export var data : Resource

@export var itemName : String
@export_multiline var description : String
@export var icon : Texture2D

@export var cost : int

@export var additionalEffects : Dictionary

func initialize():
	if data != null:
		itemName = data.name
		description = data.description
		icon = data.icon
		cost = data.cost
		additionalEffects = data.additionalEffects
