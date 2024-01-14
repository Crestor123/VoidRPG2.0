extends Button

signal buttonPressed(data)

@export var data : int
@export var target : Node

func _on_pressed():
	buttonPressed.emit(data)
