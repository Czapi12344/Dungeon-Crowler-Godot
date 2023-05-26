extends Node2D

var number_of_connections = 0
var coordinates
var roomType
enum kindOfRoom {BossRoom, TreasureRoom, ShopRoom, HealRoom, SpawnRoom, GoDownRoomWithoutBoss}
var isCleared = false
var visited = false #Player visited room
var seen = false #Player was 1 space from room
var room #Path to the room file

func setRoomType(abc):
	roomType = abc
	
var connected_rooms ={
	Vector2(1, 0): null,
	Vector2(-1, 0): null,
	Vector2(0, 1): null,
	Vector2(0, -1): null
}

var portals = {
	Vector2(1, 0): null,
	Vector2(-1, 0): null,
	Vector2(0, 1): null,
	Vector2(0, -1): null
}
