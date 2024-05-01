extends Node

class_name AdditionalEffect

#Make an enum?
#taking damage, giving damage, passive, move
var trigger = null

func _effect(data):
	#Virtual method that is overrided by specific additional effects
	pass
