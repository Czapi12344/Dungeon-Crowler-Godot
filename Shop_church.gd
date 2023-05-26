extends Area2D

var instance 
var item_holders = []

func _on_body_entered(body: CharacterBody2D):
	var scene = load("res://Village/shop_default.tscn")
	instance = scene.instantiate()
	get_parent().add_child(instance)
	instantiate_frames(instance.get_child(0).get_child(0))
	
func instantiate_frames(respItems):
	var i = 0
	
	for child in respItems.get_children():
		if "Church" in child.name:
			var item = load("res://Village/ItemHolder.tscn").instantiate()
			
		
			setItemHolder(item, i)
			
			item.position = child.position
			item.set_name("ItemPlaceHolder " + str(i))
			item.scale.y = 0.2
			item.scale.x = 0.2
		
			respItems.call_deferred("add_child", item)
			i += 1

func setItemHolder(item, i):
	if PassiveMenager.churchItems.size() <= i:
		return
	item.id = 1
	item.node = item
	item.idOfItemInArray = i
	item.itemOnDisplay = PassiveMenager.churchSprites[i]
	
	item.my_function()


func _on_body_exited(body):
	instance.queue_free()
