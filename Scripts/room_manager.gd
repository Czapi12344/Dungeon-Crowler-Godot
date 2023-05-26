extends Node

const CELL_SIZE = 16
var portals = []

var rooms_normal = []
var rooms_boss = []
var rooms_shop = []
var rooms_heal = []
var rooms_spawn = []
var rooms_go_down = []
var rooms_treasure = []

enum kindOfRoom {BossRoom, TreasureRoom, ShopRoom, HealRoom, SpawnRoom, GoDownRoomWithoutBoss}


func _ready():
	loadRooms()
	loadPortals()

func loadPortals():
	portals.append(preload("res://Portals/portal_right.tscn"))
	portals.append(preload("res://Portals/portal_left.tscn"))
	portals.append(preload("res://Portals/portal_down.tscn"))
	portals.append(preload("res://Portals/portal_up.tscn"))



func createRoom(room, roomID, fromWhichFloorShouldRoomBe: int = 1):
	#if room.roomType == kindOfRoom.BossRoom:
	#	FloorManager.createNewFloor()
	#	return
	print(fromWhichFloorShouldRoomBe)
	if room.room == null:
		room.room = random_room(room.roomType, fromWhichFloorShouldRoomBe)
		print(room.room)
		
	
	var scene_added = load(room.room).instantiate()
	scene_added.set_name("currentRoom" + str(roomID))
	scene_added.position = Vector2(0,0)
	
	teleportPlayerToMiddleOfRoom(set_teleport(scene_added, -1))
	
	var parent_ndoe = get_parent()
	parent_ndoe.add_child(scene_added)
			
	var color_of_teleport = 0
	
	for j in room.portals.keys():
		#print(j)
		if room.portals.get(j) != null:
			
			var instantiated_portal = portals[color_of_teleport].instantiate()
			instantiated_portal.position = set_teleport(scene_added, color_of_teleport)
			
			instantiated_portal.teleportToWhere = j
			
			instantiated_portal.set_name(set_name_of_portal(color_of_teleport))
			
			instantiated_portal.id = color_of_teleport
			scene_added.call_deferred("add_child", instantiated_portal)
					
			
				
		color_of_teleport += 1
	
	
func set_name_of_portal(direction):
	if direction == 0:
		return "PortalEast"
	if direction == 1:
		return "PortalWest"
	if direction == 2:
		return "PortalSouth"
	if direction == 3:
		return "PortalNorth"
		
func set_teleport(scene_added, i):
	var _spawn_node = scene_added.get_children()
	
	for child in scene_added.get_child(0).get_children():
		if i == 0 and child.get_name() == "ExitEast":
			return child.position
	for child in scene_added.get_child(0).get_children():
		if i == 1 and child.get_name() == "ExitWest":
			return child.position
	for child in scene_added.get_child(0).get_children():
		if i == 2 and child.get_name() == "ExitSouth":
			return child.position
	for child in scene_added.get_child(0).get_children():
		if i == 3 and child.get_name() == "ExitNorth":
			return child.position
	for child in scene_added.get_child(0).get_children():
		if i == -1 and child.get_name() == "Spawn":
			return child.position
			


func refreshMinimap(room, dungeon):
	room.visited = true
	room.seen = true
	
	for j in room.connected_rooms.keys():
		if room.connected_rooms.get(j) != null:
			dungeon.get(room.coordinates + j).seen = true
			dungeon.get(room.coordinates + j).visited = true
			

func loadRooms(): 
	var dir = load("res://Scripts/RoomsList.gd").new()
	rooms_normal = dir.roomsInRoomDirectory("res://Rooms/", "room_normal")
	
	rooms_treasure = dir.roomsInRoomDirectory("res://Rooms/", "room_treasure")
	rooms_boss = dir.roomsInRoomDirectory("res://Rooms/", "room_boss")
	rooms_shop = dir.roomsInRoomDirectory("res://Rooms/", "room_shop")
	rooms_heal = dir.roomsInRoomDirectory("res://Rooms/", "room_heal")
	rooms_spawn = dir.roomsInRoomDirectory("res://Rooms/", "room_spawn")
	rooms_go_down = dir.roomsInRoomDirectory("res://Rooms/", "room_go_down")
	
func random_room(whatKindOfRoom, fromWhichFloorShouldRoomBe): 
	#mozna skrocic, nie chce mi sie poki co 🤷‍♂️
	if fromWhichFloorShouldRoomBe == 0:
		return "res://Village/Village.tscn"
	
	if whatKindOfRoom == null:
		while true:
			var rand_room_index = randi() % rooms_normal.size()
			if rooms_normal[rand_room_index].find("room_normal_"+str(fromWhichFloorShouldRoomBe)) != -1:
				return rooms_normal[rand_room_index]
	
	if whatKindOfRoom == kindOfRoom.BossRoom:	
		while true:
			var rand_room_index = randi() % rooms_boss.size()
			if rooms_boss[rand_room_index].find("room_boss_"+str(fromWhichFloorShouldRoomBe)) != -1:
				return rooms_boss[rand_room_index]
				
	if whatKindOfRoom == kindOfRoom.HealRoom:	
		while true:
			var rand_room_index = randi() % rooms_heal.size()
			if rooms_heal[rand_room_index].find("room_heal_"+str(fromWhichFloorShouldRoomBe)) != -1:
				return rooms_heal[rand_room_index]
				
				
	if whatKindOfRoom == kindOfRoom.TreasureRoom:	
		while true:
			if rooms_treasure.size() <= 0:
				while true:
					var rand_room_index = randi() % rooms_normal.size()
					if rooms_normal[rand_room_index].find("room_normal_"+str(fromWhichFloorShouldRoomBe)) != -1:
						return rooms_normal[rand_room_index]
				
			var rand_room_index = randi() % rooms_treasure.size()
			if rooms_treasure[rand_room_index].find("room_treasure_"+str(fromWhichFloorShouldRoomBe)) != -1: 
				return rooms_treasure[rand_room_index]
	
	if whatKindOfRoom == kindOfRoom.ShopRoom:	
		while true:				
			var rand_room_index = randi() % rooms_shop.size()
			if rooms_shop[rand_room_index].find("room_shop_"+str(fromWhichFloorShouldRoomBe)) != -1: 
				return rooms_shop[rand_room_index]
	
	if whatKindOfRoom == kindOfRoom.SpawnRoom:	
		while true:
			var rand_room_index = randi() % rooms_spawn.size()
			if rooms_spawn[rand_room_index].find("room_spawn_"+str(fromWhichFloorShouldRoomBe)) != -1: 
				return rooms_spawn[rand_room_index]
	
	
	if whatKindOfRoom == kindOfRoom.GoDownRoomWithoutBoss:	
		while true:
			if rooms_treasure.size() <= 0:
				var rand_room_index = randi() % rooms_normal.size()
				if rooms_normal[rand_room_index].find("room_normal_"+str(fromWhichFloorShouldRoomBe)) != -1:
					return rooms_normal[rand_room_index]
				
			var rand_room_index = randi() % rooms_go_down.size()
			if rooms_go_down[rand_room_index].find("rooms_go_down_"+str(fromWhichFloorShouldRoomBe)) != -1: 
				return rooms_go_down[rand_room_index]
				
				
				
		
func teleportPlayerToMiddleOfRoom(positionOfMiddleTeleporter):
	Player.global_position = positionOfMiddleTeleporter



func destroyRoom(roomID):
	var room = get_tree().get_root().get_node("currentRoom" + str(roomID - 1))
	room.queue_free()
	

func calculate_bounds(tilemap, cell_size):
	var max_x = 0
	var max_y = 0
	var used_cells = tilemap.get_used_cells(0)
	for pos in used_cells:
		if pos.x > max_x:
			max_x = int(pos.x)
		if pos.y > max_y:
			max_y = int(pos.y)
			
	return Vector2(max_x * cell_size, max_y * cell_size)
