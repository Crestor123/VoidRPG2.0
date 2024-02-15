extends Node

@export var abilityPath : String = "res://Resources/Abilities/"
var abilityData : Dictionary

func _ready():
	var dir = DirAccess.open(abilityPath)
	if dir:
		dir.list_dir_begin()
		var file = dir.get_next()
		while file != "":
			#File should be an ability resource
			var ability = load(abilityPath + file)
			abilityData[file] = {"name": ability.name, "prerequisites": ability.prerequisites}
			file = dir.get_next()
