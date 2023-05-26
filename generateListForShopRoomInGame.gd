extends Node

func createArrayOfItemsInShopForASingleFloor():
	GlobalSignals.itemsInShop = []
	GlobalSignals.itemsInHealRoom = []
	
	for j in range(2):
		var item = load("res://heal_for_heal_room.tscn").instantiate()
		item.setId(j)
		GlobalSignals.itemsInHealRoom.append(item)
		
		
	var i = 0
	while i < 3:
		var isTrue = true
		var item = load("res://item_to_buy_in_room_shop.tscn").instantiate()
		item.chooseWeapon()
		item.setItem()
		for j in range(GlobalSignals.itemsInShop.size()):
			if item.levelOfWeapon == GlobalSignals.itemsInShop[j].levelOfWeapon && item.randomCategoryWeapon == GlobalSignals.itemsInShop[j].randomCategoryWeapon:
				isTrue = false
				
		if isTrue:
			GlobalSignals.itemsInShop.append(item)
			i += 1
		
	if randi_range(0,100) > 50:
		var item = load("res://item_to_buy_in_room_shop.tscn").instantiate()
		item.setHP()
		GlobalSignals.itemsInShop.append(item)
	else:
		var item = load("res://item_to_buy_in_room_shop.tscn").instantiate()
		item.setDMG()
		GlobalSignals.itemsInShop.append(item)
		
	
		
