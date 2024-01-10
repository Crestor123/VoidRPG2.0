extends Node2D

@export var data : Resource
@export var abilityObject : PackedScene

@onready var abilities = $AbilityComponent
@onready var stats = $StatComponent

var memberName : String
var isActive = false

func initialize():
	name = data.name
	stats.initialize(data)
	abilities.initialize(data.abilities)

func startTurn():
	isActive = true
	print(self, " is active!")
