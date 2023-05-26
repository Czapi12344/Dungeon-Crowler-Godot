extends Node

func _process(_delta):
	$AnimationPlayer.play("portal_down_anim")

func _on_body_entered(body: CharacterBody2D):
	FloorManager.createNewFloor()
	
func _on_body_exited(body: CharacterBody2D):
	pass
