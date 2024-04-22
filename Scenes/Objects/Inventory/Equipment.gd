extends ItemNode

@export_enum ("head", "body", "legs", "feet", "ring", "weapon") var slot : String

func initialize():
	if data != null:
		slot = data.slot
	super.initialize()
