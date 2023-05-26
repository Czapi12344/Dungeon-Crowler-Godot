extends Node
#Poniewaz potrzebne sa 3 pokoje z 1 odnoga, moze pojawic sie problem ze czasami gre wywala, bo sie takie nie zrespily i generator probowal je losowac znowu w kolko 
var room = preload("res://Scripts/room.tscn")

var min_number_rooms = 17
var max_number_rooms = 22
enum kindOfRoom {BossRoom, TreasureRoom, ShopRoom, HealRoom, SpawnRoom, GoDownRoomWithoutBoss}
var generation_chance = 60
var size = 0

func generate(room_seed, generateVillage: int = 0):
	size = floor(randf_range(min_number_rooms, max_number_rooms))
	seed(room_seed)
	var dungeon = {}
	
	
	dungeon[Vector2(0, 0)] = room.instantiate()
	
	if generateVillage != 0:
		return dungeon
	
	dungeon[Vector2(0,0)].coordinates = Vector2(0,0)
	size -= 1
	
	while size > 0:
		for i in dungeon.keys():
			if randi_range(0, 100) < generation_chance:
				var direction = randi_range(0, 4)
				if direction == 0:
					setRoom(i, Vector2(1,0), dungeon)
						
				elif direction == 1:
					setRoom(i, Vector2(-1,0), dungeon)
					
				elif direction == 2:
					setRoom(i, Vector2(0, 1), dungeon)
	
				elif direction == 3:
					setRoom(i, Vector2(0, -1), dungeon)
	
		
	#while(!is_qualified_for_floor(dungeon)):
	#	for i in dungeon.keys():
	#		if dungeon != null:
	#			dungeon.get(i).queue_free()
	#		var sed = room_seed * randi_range(-1,1) + randi_range(-100,100)
	#		dungeon = generate(sed)
	setSpecialRooms(dungeon)
	return dungeon
	

func setRoom(i, vector, dungeon):
	var new_room_position = i + vector
	if !dungeon.has(new_room_position):
		dungeon[new_room_position] = room.instantiate()
		dungeon[new_room_position].coordinates = new_room_position
		size -= 1
	if(dungeon.get(i).connected_rooms.get(vector) == null):	
		connect_rooms(dungeon.get(i), dungeon.get(new_room_position), vector)
		
		
func is_qualified_for_floor(dungeon):
	var rooms_with_only_one_connection = 0 
	for i in dungeon.keys():
		if(dungeon.get(i).number_of_connections == 1):
			rooms_with_only_one_connection += 1
	return rooms_with_only_one_connection >= 3
	
func setSpecialRooms(dungeon):
	spawnRoom(dungeon)
	bossRoom(dungeon)
	treasureRoom(dungeon)
	shopRoom(dungeon)
	healRoom(dungeon)


func spawnRoom(dungeon):
	dungeon[Vector2(0, 0)].setRoomType(kindOfRoom.SpawnRoom)
	

func bossRoom(dungeon):
	var bossRoomLocation
	for i in dungeon.keys():
		if bossRoomLocation == null:
			bossRoomLocation = i
			continue
		if abs(i.x) + abs(i.y) > abs(bossRoomLocation.x) + abs(bossRoomLocation.y) && dungeon[i].number_of_connections == 1:
			bossRoomLocation = i
	
	dungeon[bossRoomLocation].setRoomType(kindOfRoom.BossRoom)
	
	
	
func treasureRoom(dungeon):
	var roomLocation
	for i in dungeon.keys():
		if roomLocation == null:
			roomLocation = i
			continue
		if dungeon[i].number_of_connections == 1 && dungeon[i].roomType != kindOfRoom.BossRoom  && dungeon[i].roomType != kindOfRoom.GoDownRoomWithoutBoss:
			roomLocation = i
			break
	dungeon[roomLocation].setRoomType(kindOfRoom.TreasureRoom)
	
func shopRoom(dungeon):
	var roomLocation
	for i in dungeon.keys():
		if roomLocation == null:
			roomLocation = i
			continue
		if dungeon[i].number_of_connections == 1 && dungeon[i].roomType != kindOfRoom.BossRoom  && dungeon[i].roomType != kindOfRoom.GoDownRoomWithoutBoss && dungeon[i].roomType != kindOfRoom.TreasureRoom:
			roomLocation = i
			break

	dungeon[roomLocation].setRoomType(kindOfRoom.ShopRoom)
	
func healRoom(dungeon):
	var roomLocation
	for i in dungeon.keys():
		if roomLocation == null:
			roomLocation = i
			continue
		if randi_range(0, 100) > 80 && abs(i.x) + abs(i.y) > 1 && dungeon[i].roomType != kindOfRoom.SpawnRoom && dungeon[i].roomType != kindOfRoom.BossRoom  && dungeon[i].roomType != kindOfRoom.GoDownRoomWithoutBoss && dungeon[i].roomType != kindOfRoom.TreasureRoom:
			roomLocation = i
			break
	dungeon[roomLocation].setRoomType(kindOfRoom.HealRoom)
	
		
func connect_rooms(room1, room2, direction):
		room1.connected_rooms[direction] = room2
		room2.connected_rooms[-direction] = room1
		room1.number_of_connections += 1
		room2.number_of_connections += 1
		
		if direction.x != 0:
			room1.portals[direction] = Vector2(0, 0)
			room2.portals[-direction] = Vector2(0, 0)
		else:
			room1.portals[direction] = Vector2(0, 0)
			room2.portals[-direction] = Vector2(0, 0)
		
		
		

	

