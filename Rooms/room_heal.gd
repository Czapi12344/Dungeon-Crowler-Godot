extends Node2D


func _ready():
	var i = 0
	
	for child in get_child(0).get_children():
		if child.get_name().contains("item_"):
			
			if GlobalSignals.itemsInHealRoom[i] != null:
				print(GlobalSignals.itemsInHealRoom[i].id)
				var heal_instantiated = GlobalSignals.itemsInHealRoom[i].duplicate()
				heal_instantiated.id = i
				heal_instantiated.position = child.position
				call_deferred("add_child", heal_instantiated)
			i += 1
