extends Control

@onready var buttonContainer = $ButtonContainer

@export var partyMemberButton : PackedScene

var destination : Node = null
signal selected(partyMember : Node)

func initialize(partyList : Array, caller : Node):
	destination = caller
	if destination.has_method("partyMemberSelected"):
		selected.connect(destination.partyMemberSelected)
	
	for partyMember in partyList:
		var newButton = partyMemberButton.instantiate()
		buttonContainer.add_child(newButton)
		newButton.initialize(partyMember)
		newButton.buttonPressed.connect(partyMemberSelected)
	pass

func partyMemberSelected(partyMember : Node):
	print(partyMember, " selected")
	selected.emit(partyMember)
	visible = false
	for item in buttonContainer.get_children():
		item.queue_free()
		
	if destination.has_method("partyMemberSelected"):
		selected.disconnect(destination.partyMemberSelected)
		destination = null
