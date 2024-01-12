extends Node3D

@export var data : Array[Resource]
@export_enum ("enemy") var type : String

signal interacting(type, data)

func initialize():
	for item in data:
		#Create a mesh object for each resource given
		#Position them equidistantly from each other
		#The meshes should rotate with respect to the player
		pass
	pass

func interact():
	interacting.emit(type, data)
	pass
