extends Node3D

@export var data : Array[Resource]
@export_enum ("enemy") var type : String

signal interacting(type, data)

func interact():
	interacting.emit(type, data)
	pass
