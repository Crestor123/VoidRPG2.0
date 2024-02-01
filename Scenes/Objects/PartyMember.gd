extends Node2D

@export var data : Resource
@export var abilityObject : PackedScene

@onready var abilities = $AbilityComponent
@onready var stats = $StatComponent

var memberName : String
var isActive : bool = false
var alive : bool = true

signal updateHealthBar(value)
signal dead(data)

func initialize():
	name = data.name
	stats.initialize(data)
	abilities.initialize(data.abilities)
	
	stats.healthZero.connect(die)

func startTurn(_turnCount : int):
	isActive = true
	print(self, " is active!")

func die():
	#print(self, " is dead")
	alive = false
	dead.emit(self)
