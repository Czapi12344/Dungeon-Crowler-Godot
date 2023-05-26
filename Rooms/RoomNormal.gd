extends Node2D


func _ready():
	for child in get_child(0).get_children():
		if child.get_name().contains("meleeSpawn_") :
		
			var instantiated_portal = load("res://Enemies/Pchla.tscn").instantiate()
			instantiated_portal.position = child.position
			
			call_deferred("add_child", instantiated_portal)
			
		if child.get_name().contains("rangedSpawn_") :
		
			var instantiated_portal = load("res://Enemies/Kapturek.tscn").instantiate()
			instantiated_portal.position = child.position
			
			call_deferred("add_child", instantiated_portal)
				
			
