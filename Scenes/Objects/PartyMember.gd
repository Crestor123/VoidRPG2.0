extends Node2D

@export var data : Resource
@export var abilityObject : PackedScene

@onready var abilities = $AbilityComponent
@onready var stats = $StatComponent

var experience : int = 0
var xpToLevel : int = 0

var memberName : String
var isActive : bool = false
var alive : bool = true

signal updateHealthBar(value)
signal dead(data)

func initialize():
	name = data.name
	stats.initialize(data)
	abilities.initialize(data.abilities)
	
	xpToLevel = xpToNextLevel(stats.level)
	stats.healthZero.connect(die)

func xpToNextLevel(level : int) -> int:
	#returns the amount of experience needed to level up
	var exponent = 1.5;
	var baseXP = 30;
	return round(baseXP * (pow(level, exponent)));
	
func levelUp():
	#Increase stats, set xpToLevel
	pass

func startTurn(_turnCount : int):
	isActive = true
	stats.tickBuffs()
	print(self, " is active!")

func die():
	#print(self, " is dead")
	alive = false
	dead.emit(self)
