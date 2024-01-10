extends Control

@export var abilityObject : PackedScene
@onready var abilityContainer = $MarginContainer/ScrollContainer/VBoxContainer

signal chooseAbility(data, target)

func updateAbilities(abilityComponent : Node):
	#Clear out the ability container
	for item in abilityContainer.get_children():
		item.queue_free()
	
	#Connect the ability signal to the party member
	chooseAbility.connect(abilityComponent.useAbility)
	
	#Populate the list of abilities with the abilities given
	for item in abilityComponent.get_children():
		print("creating button for ", item.abilityName)
		var ability = abilityObject.instantiate()
		abilityContainer.add_child(ability)
		ability.buttonPressed.connect(abilityTransmit)
		ability.initialize(item)
	pass

func abilityTransmit(ability : Node):
	chooseAbility.emit(ability, null)
	pass
