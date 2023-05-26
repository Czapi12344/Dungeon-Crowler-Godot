extends Node2D



func _ready():
	var i = 0
	for child in get_child(0).get_children():
		if child.get_name().contains("item_"):
			if GlobalSignals.itemsInShop[i] == null:
				i += 1
				continue
			var item_to_buy = GlobalSignals.itemsInShop[i].duplicate()
			
			item_to_buy.setAll(GlobalSignals.itemsInShop[i])
			
			item_to_buy.position = child.position
			item_to_buy.id = i
			GlobalSignals.itemsInShop[i].id = i
			item_to_buy.scale.x = 0.1
			item_to_buy.scale.y = 0.1
			call_deferred("add_child", item_to_buy)
			i += 1
