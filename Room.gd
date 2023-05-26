extends Node2D

var number_of_connections = 0
var coordinates
var isBossRoom = false
var isCleared = false
var room #Path to the room file

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
