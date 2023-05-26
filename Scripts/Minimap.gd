extends Node2D

var dungeon = {}
var not_near_node_sprite = load("res://Assets/map_nodes1.png")
var node_sprites = []
var branch_sprite = load("res://Assets/map_nodes3.png")
var boss_node_sprite = load("res://Assets/boss_room_node.png")
var treasure_room_sprite = load("res://Assets/treasure_room_node.png")
var healing_room_sprite = load("res://Assets/healing_room_node.png")
var shop_room_sprite = load("res://Assets/store_room_node.png")
var go_down_room_sprite = load("res://Assets/go_down_room_node.png")

var scale_of_minimap = 2.5  
var current_pos = Vector2(0, 0)
var current_pos_based_on_vector_position = Vector2(0, 0)
var map_node
enum kindOfRoom {BossRoom, TreasureRoom, ShopRoom, HealRoom, SpawnRoom, GoDownRoomWithoutBoss}

#@onready var map_node = $MapNode
#@onready var current_room_node = $CurrentMap

func set_nodes():
	node_sprites.append(load("res://Assets/map_nodes2.png"))
	node_sprites.append(load("res://Assets/map_node_down.png"))
	node_sprites.append(load("res://Assets/map_node_left.png"))
	node_sprites.append(load("res://Assets/map_node_right.png"))
	node_sprites.append(load("res://Assets/map_node_up.png"))
	
	

func _ready():
	map_node = $MapNode
	reloadNewMinimap()

func reloadNewMinimap():
	dungeon = FloorManager.dungeon
	set_nodes()
	loadMap()
	
func resetCoordinates():
	current_pos_based_on_vector_position = Vector2(0, 0)
	current_pos = Vector2(0, 0)

func changeRoom(ev):
	var temp = current_pos
	current_pos_based_on_vector_position += ev
	if ev == Vector2(0, -1):
		current_pos.y -= 10 * scale_of_minimap
		changeNode(temp)
	if ev == Vector2(0, 1):
		current_pos.y += 10 * scale_of_minimap
		changeNode(temp)
	if ev == Vector2(1, 0):
		current_pos.x += 10 * scale_of_minimap
		changeNode(temp)
	if ev == Vector2(-1, 0):
		current_pos.x -= 10 * scale_of_minimap
		changeNode(temp)

func loadMap():
	#czyszczenie mapy
	for i in range(0, map_node.get_child_count()):
		map_node.get_child(i).queue_free()
	#generowanie nowej mapy
	#dungeon.get(Vector2(0, 0)).visited = true
	#dungeon.get(Vector2(0, 0)).seen = true
	
	for i in dungeon.keys():
		
		#if dungeon.get(i).visited == false:
		#	continue
			
		var temp = Sprite2D.new()
		temp.texture = not_near_node_sprite
		temp.set_scale(Vector2(scale_of_minimap, scale_of_minimap))
		
		set_special_nodes(dungeon, i, temp)
		
		map_node.add_child(temp)
		temp.z_index = 1
		temp.position = i * 10 * scale_of_minimap
		
		#load_connections(temp, i)
		#if dungeon.get(i).seen == false:
		#	continue
			
		var c_rooms = dungeon.get(i).connected_rooms
		if(c_rooms.get(Vector2(1, 0)) != null):
			show_connections(temp,Vector2(5, 0.5), i)
		if(c_rooms.get(Vector2(0, 1)) != null):
			show_connections(temp,Vector2(-0.5, 5), i)
			
	changeNode(Vector2(0, 0))

	
func set_special_nodes(dungeon, i, temp):
	#zmienic na prawidlowe textury
	if dungeon[i].roomType == kindOfRoom.BossRoom:
			temp.texture = boss_node_sprite
			
	elif dungeon[i].roomType == kindOfRoom.TreasureRoom:
			temp.texture = treasure_room_sprite
			
	elif dungeon[i].roomType == kindOfRoom.GoDownRoomWithoutBoss:
			temp.texture = go_down_room_sprite
			
	elif dungeon[i].roomType == kindOfRoom.HealRoom:
			temp.texture = healing_room_sprite
		
	elif dungeon[i].roomType == kindOfRoom.ShopRoom:
			temp.texture = shop_room_sprite

		
			
#idk czy spawnRoom powinien miec inna ikonke na minimapie
	#elif dungeon[i].roomType == kindOfRoom.SpawnRoom:
	#		temp.texture = boss_node_sprite
		
	
	
func show_connections(temp, vec, i):
	temp = Sprite2D.new()
	temp.texture = branch_sprite
	map_node.add_child(temp)
	temp.z_index = 0
	if vec == Vector2(-0.5, 5):
		temp.rotation_degrees = 90
	temp.set_scale(Vector2(scale_of_minimap, scale_of_minimap))
	temp.position = i * 10 * scale_of_minimap + vec


func isSpecial(texture_to_check):
	#todo: sprawdzic czy podana textura pokrywa sie z pokojami specjalnymi, i jesli tak, to zwrocic true, bo poki co wszystkie to tylko i wylacznie boss_room_nody
	if texture_to_check == boss_node_sprite:
		return true
	elif texture_to_check == treasure_room_sprite:
		return true
	elif texture_to_check == healing_room_sprite:
		return true
	elif texture_to_check == shop_room_sprite:
		return true
	elif texture_to_check == go_down_room_sprite:
		return true
		
	return false
	
func changeNode(vec):
	for i in map_node.get_child_count():
		if isSpecial(map_node.get_child(i).texture):
			continue
		
		if map_node.get_child(i).position == vec:
			map_node.get_child(i).texture = not_near_node_sprite
			
		if map_node.get_child(i).position == Vector2(vec.x, vec.y - 10 * scale_of_minimap):
			map_node.get_child(i).texture = not_near_node_sprite
		if map_node.get_child(i).position == Vector2(vec.x, vec.y + 10 * scale_of_minimap):
			map_node.get_child(i).texture = not_near_node_sprite
		if map_node.get_child(i).position == Vector2(vec.x - 10 * scale_of_minimap, vec.y):
			map_node.get_child(i).texture = not_near_node_sprite
		if map_node.get_child(i).position == Vector2(vec.x + 10 * scale_of_minimap, vec.y):
			map_node.get_child(i).texture = not_near_node_sprite

			
	for i in map_node.get_child_count():
		if isSpecial(map_node.get_child(i).texture):
			continue
		var c_rooms = dungeon.get(current_pos_based_on_vector_position).connected_rooms
		
		if map_node.get_child(i).position == current_pos:
			map_node.get_child(i).texture = node_sprites[0]
		
		if map_node.get_child(i).position == Vector2(current_pos.x, current_pos.y - 10 * scale_of_minimap) && (c_rooms.get(Vector2(0, -1)) != null):
			map_node.get_child(i).texture = node_sprites[4]
		if map_node.get_child(i).position == Vector2(current_pos.x, current_pos.y + 10 * scale_of_minimap)  && (c_rooms.get(Vector2(0, 1)) != null):
			map_node.get_child(i).texture = node_sprites[1]
		if map_node.get_child(i).position == Vector2(current_pos.x - 10 * scale_of_minimap, current_pos.y)  && (c_rooms.get(Vector2(-1, 0)) != null):
			map_node.get_child(i).texture = node_sprites[2]
		if map_node.get_child(i).position == Vector2(current_pos.x + 10 * scale_of_minimap, current_pos.y)  && (c_rooms.get(Vector2(1, 0)) != null):
			map_node.get_child(i).texture = node_sprites[3]


func getVerticalMeasurmentsOfMinimapFromPoint0AndCountingAboveIt():
	var min
	var idk_nie_chce_mi_sie_tego_inaczej_robic = true
	for i in map_node.get_child_count():
		if idk_nie_chce_mi_sie_tego_inaczej_robic:
			min = map_node.get_child(i).position.y
			idk_nie_chce_mi_sie_tego_inaczej_robic = false
		if map_node.get_child(i).position.y < min:
			min = map_node.get_child(i).position.y
			
	return min
