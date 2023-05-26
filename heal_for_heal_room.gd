extends Node2D

var id = 0

func setId(newId):
	id = newId

func _on_area_2d_body_entered(body):
	if Player.hp == Player.maxHP:
		return
	elif Player.hp + 50 < Player.maxHP:
		Player.hp += 50
	else:
		Player.hp = Player.maxHP
	GlobalSignals.itemsInHealRoom[id] = null
	queue_free()
