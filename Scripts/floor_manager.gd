extends Node


var dungeon = {}
var asd = false
var player
var currentRoomID = Vector2(0, 0)
var minimap
var floor_num = 0 #0 == Village
var roomID = 0



func _ready():
	generate_Village_floor()


func generate_Village_floor():
	dungeon = DungeonGenerator.generate(randi_range(0,1000), -1)
	minimap = get_node("/root/World/GUI/VBoxContainer/Node2D")
	#get_viewport().connect("size_changed", set_minimap)
	

func generate_new_floor():
	dungeon = DungeonGenerator.generate(randi_range(0,1000))
	GenerateListForShopRoomInGame.createArrayOfItemsInShopForASingleFloor()
	Village.playerBoughtAnItem()
	floor_num += 1
	
func _process(_delta):
	if asd == false:
		#print(dungeon.get(Vector2(0,0)), roomID)
		RoomManager.createRoom(dungeon.get(Vector2(0,0)), roomID, floor_num)
		set_minimap()
		
	asd = true


func createNewFloor():
	
	roomID += 1
	GlobalSignals.emit_signal("clearBullets")
	#Player.global_position = Vector2(0, 0) #global pozycje zmienic tak jakby gracz mialby sie porusyc normalnie, wiec raczej to usunac, po tym jak zostanie to zaimplementowane
	

	generate_new_floor()
	RoomManager.createRoom(dungeon.get(Vector2(0, 0)), roomID)
	RoomManager.destroyRoom(roomID)
	#RoomManager.createRoom(dungeon.get(Vector2(0,0)), roomID)
	currentRoomID = Vector2(0, 0)
	minimap.resetCoordinates()
	minimap.reloadNewMinimap()
	

	return
	
	
func changeRoom(roomVec, _id):
		
	GlobalSignals.emit_signal("clearBullets")
	
	roomID += 1
	minimap.changeRoom(roomVec)
	RoomManager.createRoom(dungeon.get(Vector2(roomVec + currentRoomID)), roomID)
	RoomManager.destroyRoom(roomID)
		
	#RoomManager.refreshMinimap(dungeon.get(Vector2(roomVec + currentRoomID)), dungeon)
	minimap.loadMap()
	currentRoomID += roomVec
	
	
func set_minimap():
	var vector2DGlobalResponsibleAsToWhereToSetMinimap = get_global_position_85_20()
	minimap.global_position = vector2DGlobalResponsibleAsToWhereToSetMinimap
	pass
	
	
func get_global_position_85_20():
	
	var window_size = get_viewport().size
	
	var x = window_size.x * 0.9
	if x < window_size.x - 150:
		x = window_size.x - 150
		
	var y = window_size.y * 0.175
	if y > 150:
		y = 150
	
	#var heightToSubtract = minimap.getVerticalMeasurmentsOfMinimapFromPoint0AndCountingAboveIt()
	#y += abs(heightToSubtract)
	
	return Vector2(x, y)
