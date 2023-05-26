extends Node

@onready var timer = $Timer

func _process(_delta):
	$AnimationPlayer.play("portal_down_anim")
		
func _on_body_entered(body: CharacterBody2D): # idk czy nie bedzie trzeba zmienic, w sensie czy potwory ich nie beda uruchamiac 
	teleport_to_another_room()
	
func teleport_to_another_room():
	FloorManager.createNewFloor()
	
