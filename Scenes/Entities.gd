extends Node

#Uses the grid layout and probabilities to generate entities
@export var enemyPath : String
@export var entityObject : PackedScene

var enemyDir : DirAccess

func generate(maze : Array, enemyWeight : int):
	#maze is an array of dungeonNodes, enemyWeight is an integer 1-100
	enemyDir = DirAccess.open(enemyPath)
	
	var rand : int = 0
	for cell in maze:
		if !cell.wall:
			rand = randi_range(1, 100)
			if rand <= enemyWeight:
				spawnEnemy(cell)
				pass
	pass

func spawnEnemy(cell):
	if !enemyDir:	#Error
		return
	enemyDir.list_dir_begin()
	var file = enemyDir.get_next()
	#while file != "":
	print("Found ", file)
	var newEntity = entityObject.instantiate()
	add_child(newEntity)
	newEntity.data.append(load(enemyPath + "/" + file))
	newEntity.type = "enemy"
	print(cell.coordinates)
	newEntity.global_position = Vector3(cell.coordinates.x, 0.80, cell.coordinates.y)
		#file = enemyDir.get_next()
	pass
