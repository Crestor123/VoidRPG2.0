extends Node3D

@onready var Ray = $RayCast3D

var moving = false
var tile_size = 2

signal interacting

func move(direction : String):
	print("moving ", direction)
	
	var collision
	
	if moving == true:
		return
	
	#Check the grid space that the player is moving into using a raycast
	if direction == "up" or direction == "down" or direction == "select":
		if direction == "down":
			Ray.target_position.z = Ray.target_position.z * -1
		Ray.force_raycast_update()
		if Ray.is_colliding():
			collision = Ray.get_collider()
			if collision.get_parent():
				collision = collision.get_parent()
			select(collision)
			return
		if direction == "down":
			Ray.target_position.z = Ray.target_position.z * -1
		
			

	
	if direction == "up":
		var tween = create_tween()
		tween.tween_property(self, "position", 
			position - Vector3(0, 0, tile_size).rotated(Vector3.UP, rotation.y), 0.5)
		moving = true
		await tween.finished
		moving = false
	
	if direction == "down":
		var tween = create_tween()
		tween.tween_property(self, "position", 
			position + Vector3(0, 0, tile_size).rotated(Vector3.UP, rotation.y), 0.5)
		moving = true
		await tween.finished
		moving = false
		
	if direction == "left" or direction == "right":
		turn(direction)
		return
	
func turn(direction : String):
	print("turning", direction)
	
	if rotation_degrees.y == 360 or rotation_degrees.y == -360:
		rotation_degrees.y = 0
	
	if direction == "left":
		var tween = create_tween()
		tween.tween_property(self, "rotation_degrees", 
			rotation_degrees + Vector3(0, 90, 0), 0.5)
		moving = true
		await tween.finished
		moving = false
	
	if direction == "right":
		var tween = create_tween()
		tween.tween_property(self, "rotation_degrees", 
			rotation_degrees - Vector3(0, 90, 0), 0.5)
		moving = true
		await tween.finished
		moving = false

func select(entity):
	interacting.connect(entity.interact)
	interacting.emit()
	interacting.disconnect(entity.interact)
	pass
