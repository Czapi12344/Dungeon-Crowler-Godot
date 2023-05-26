extends Node


var entered = false
var teleportToWhere


func _on_body_entered(body: CharacterBody2D):
	GameLoop.changeRoom(teleportToWhere)
	entered = true
	


func _on_body_exited(body: CharacterBody2D):
	entered = false
