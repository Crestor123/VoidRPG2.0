extends Control

@onready var Select = $CenterContainer/HBoxContainer/VBoxContainer/Select
@onready var UpButton = $CenterContainer/HBoxContainer/VBoxContainer/Up
@onready var LeftButton = $CenterContainer/HBoxContainer/Left
@onready var RightButton = $CenterContainer/HBoxContainer/Right
@onready var DownButton = $CenterContainer/HBoxContainer/VBoxContainer/Down

signal buttonPressed(button : String)

func emitButton(button : String):
	buttonPressed.emit(button)
	pass

func _on_left_pressed():
	emitButton("left")
	pass # Replace with function body.

func _on_up_pressed():
	emitButton("up")
	pass # Replace with function body.

func _on_select_pressed():
	emitButton("select")
	pass # Replace with function body.

func _on_down_pressed():
	emitButton("down")
	pass # Replace with function body.

func _on_right_pressed():
	emitButton("right")
	pass # Replace with function body.
