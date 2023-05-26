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
	var nameItemBase = "Item "
	for child in respItems.get_children():
		var nameItem = nameItemBase + str(i + 1)
		if nameItem in child.name:
			var item = load("res://Village/ItemHolder.tscn").instantiate()
		
			setItemHolder(item, i)
			
			item.position = child.position
			item.set_name("ItemPlaceHolder " + str(i))
			item.scale.y = 0.2
			item.scale.x = 0.2
			respItems.call_deferred("add_child", item)
			i += 1

func setItemHolder(item, i):
	if PassiveMenager.varietyItems.size() <= i:
		item.visible = false
		return
	item.id = 2
	item.node = item
	item.idOfItemInArray = i
	item.itemOnDisplay = PassiveMenager.varietySprites[i]
	item.my_function()

func _on_area_entered(_area):
	pass # Replace with function body.


func _on_body_exited(_body):
	instance.queue_free()
