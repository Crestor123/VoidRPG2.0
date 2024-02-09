extends Control

@export var ExperienceObject : PackedScene

@onready var cntrExperience = $VBoxContainer/ScrollContainer/ExperienceContainer
@onready var btnContinue = $VBoxContainer/Continue

signal continueButton

#Display Experience gained by each party member
#Then display experience gained for each ability one party member at a time
#Skip button that jumps to the end

func initialize(partyList : Array[Node], experience : int):
	for item in cntrExperience.get_children(): item.queue_free()
	
	print("init experience UI")
	for item in partyList:
		var xpBar = ExperienceObject.instantiate()
		cntrExperience.add_child(xpBar)
		xpBar.initialize(item.name, 100 * (float(item.experience) / float(item.xpToLevel)))
		xpBar.healthBar.setBar(100 * (float(item.experience + experience) / float(item.xpToLevel)))
	pass


func _on_continue_pressed():
	continueButton.emit()
