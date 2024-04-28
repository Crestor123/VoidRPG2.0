extends CanvasLayer

@export var partySelectorUI : Node

var currentOverlay : Node = null

func cancel():
	if currentOverlay:
		currentOverlay.cancel()
	pass
