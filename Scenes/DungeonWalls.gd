extends GridMap

class dungeonNode:
	var visited : bool = false
	var connections : Array[dungeonNode] = []
	var wall : bool = false
	var coordinates : Vector2

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
				dnode.wall = true
			if (i % 2 == 0 || j % 2 == 0):
				#Interior walls
				dnode.visited = false
				dnode.wall = true
			dnode.coordinates = Vector2(i * 2 + 1, j * 2 + 1)
			maze.append(dnode)
			
	generateMaze(1, 1)

func withinMaze(X : int, Y : int):
	return (0 <= X && X < width && 0 <= Y && Y < height)
	pass

func generateMaze(currentX : int, currentY : int):
	var dnode = maze[currentY + width * currentX]
	dnode.visited = true
	dnode.wall = false
	
	var directions = [1, 2, 3, 4]
	while !directions.is_empty():
		var dir = directions.pick_random()
		directions.erase(dir)
		
		var newX = 0
		var newY = 0
		var wallX = 0
		var wallY = 0
		
		#Based on the direction chosen, generate the coordinates
		if dir == 1:	#Up
			newX = currentX
			newY = currentY - 2
			wallX = currentX
			wallY = currentY - 1
		elif dir == 2:	#Down
			newX = currentX
			newY = currentY + 2
			wallX = currentX
			wallY = currentY + 1
		elif dir == 3:	#Left
			newX = currentX - 2
			newY = currentY
			wallX = currentX - 1
			wallY = currentY
		elif dir == 4:	#Right
			newX = currentX + 2
			newY = currentY
			wallX = currentX + 1
			wallY = currentY 
		else:
			newX = currentX
			newY = currentY
			wallX = currentX
			wallY = currentY
		
		if !withinMaze(newX, newY):
			continue
		
		if maze[newY + width * newX].visited == false:
			maze[wallY + width * wallX].wall = false
			generateMaze(newX, newY)
	pass

func generateTiles():
	#Using the maze, generate the actual dungeon
	for i in range(height):
		for j in range(width):
			#set_cell_item(Vector3(i, -1, j), 1)
			var dnode = maze[j + width * i]
			print(dnode.wall, " ")
			if dnode.wall == true:
				set_cell_item(Vector3(i, 0, j), 0)
				set_cell_item(Vector3(i, -1, j), 0)
		print("")
	pass
