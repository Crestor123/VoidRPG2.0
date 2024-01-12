extends Button

signal buttonPressed(data)

@export var data : int

func _on_pressed():
	buttonPressed.emit(data)
