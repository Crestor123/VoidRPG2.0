extends Node3D

@onready var staticBody = $StaticBody3D
@onready var collision = $StaticBody3D/CollisionShape3D
#@onready var mesh = $EntityMesh

@export var entityMesh : PackedScene
@export var data : Array[Resource]
@export var preInteractSprites : Array[Resource]
@export var postInteractSprites : Array[Resource]
@export var billboard : bool
@export_enum ("enemy", "door") var type : String

signal interacting(ID, type, data)

func initialize(newPosition : Vector3 = Vector3.ZERO, newRotation : Vector3 = Vector3.ZERO, newBillboard : bool = true):
	if newPosition != Vector3.ZERO: global_position = newPosition
	if newRotation != Vector3.ZERO: rotation = newRotation
	billboard = newBillboard
	
	if type == "door":
		billboard = false
		
	if preInteractSprites.size() > 0:
		for sprite in preInteractSprites:
			var newMesh = entityMesh.instantiate()
			add_child(newMesh)
			newMesh.mesh.material.albedo_texture = sprite
			if !billboard:
				newMesh.mesh.material.set_cull_mode(2)	#Disable culling
			newMesh.mesh.material.set_billboard_mode(billboard)
			#newMesh.mesh.material.transparency = 0
			newMesh.mesh.material.render_priority = 1
		return
		
		pass
	
	for item in data:
		#Create a mesh object for each resource given
		#Position them equidistantly from each other
		#The meshes should rotate with respect to the player
		var newMesh = entityMesh.instantiate()
		add_child(newMesh)
		#Enemies and other objects are reduced in size to render properly
		newMesh.mesh.size = (Vector2(1.5,1.5))
		newMesh.mesh.material.albedo_texture = item.sprite
		newMesh.mesh.material.set_billboard_mode(billboard)
		newMesh.mesh.material.render_priority = 1
		pass
	pass

func disableCollision(disable : bool = true):
	collision.disabled = disable

func confirmInteract():
	for child in get_children():
		if child != staticBody: child.queue_free()
	
	for sprite in postInteractSprites:
		var newMesh = entityMesh.instantiate()
		add_child(newMesh)
		newMesh.mesh.material.albedo_texture = sprite
		if !billboard:
			newMesh.mesh.material.set_cull_mode(2)	#Disable culling
		newMesh.mesh.material.set_billboard_mode(billboard)
		
	if type == "door":
		disableCollision()
	pass

func interact():
	interacting.emit(self, type, data)
	pass
