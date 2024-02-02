extends Control

@export var ExperienceObject : PackedScene

@onready var cntrExperience = $ColorRect/VBoxContainer/ScrollContainer/ExperienceContainer
@onready var btnContinue = $ColorRect/VBoxContainer/Continue

#Display Experience gained by each party member
#Then display experience gained for each ability one party member at a time
#Skip button that jumps to the end

func initialize(partyList : Array[Node], experience : int):
	for item in partyList:
		var xpBar = ExperienceObject.instantiate()
		
	pass
