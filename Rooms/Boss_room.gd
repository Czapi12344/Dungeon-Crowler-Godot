extends Node2D

func _ready():
	for child in get_child(0).get_children():
		if child.get_name() == "ExitNextFloor":
		
			var instantiated_portal = load("res://Portals/portal_change_floor.tscn").instantiate()
			instantiated_portal.position = child.position
			
			call_deferred("add_child", instantiated_portal)
			
