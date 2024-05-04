extends GridMap

class dungeonNode:
	var visited : bool = false
	var connections : Array[dungeonNode] = []

var height : int
var width : int
var maze : Array[dungeonNode] = []

func initialize(width : int, height : int):
	#Width and height must be odd
	if width % 2 == 0: width += 1
	if height % 2 == 0: height += 1
	self.width = width
	self.height = height
	
	#Create an array of dungeon nodes
	for i in range(height):
		for j in range(width):
			var dnode = dungeonNode.new()
			if (i == 0 || i == height - 1 || j == 0 || j == width - 1):
				#Create an outer layer of walls
				dnode.visited = true
			maze.append(dnode)

func generateMaze():
	pass

func generateTiles():
	#Using the maze, generate the actual dungeon
	for i in range(height):
		for j in range(width):
			#set_cell_item(Vector3(i, -1, j), 1)
			var dnode = maze[j + width * i]
			if dnode.visited == true && dnode.connections.is_empty():
				set_cell_item(Vector3(i, 0, j), 0)
				set_cell_item(Vector3(i, -1, j), 0)
	pass
