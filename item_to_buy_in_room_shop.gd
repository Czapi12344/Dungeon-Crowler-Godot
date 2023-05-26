extends Node2D

var displayItem

var randomCategoryWeapon = 0
var levelOfWeapon = 0
var itemCost = 0
var id = 0
var hpCost = 20
var dmgCost = 25
var addDamage = false
var addHP = false

var weapon_cost  = [[ 10 , 30 , 79],
					[ 15 , 45 , 70],
					[ 17 , 50 , 90],
					[ 12 , 45 , 80],
					[ 8 , 30 , 105],
					[ 10 , 20 , 60]]
					
func chooseWeapon():
	randomCategoryWeapon = randi_range(0, WeaponsMenager.weapons2d.size() - 1)
	levelOfWeapon = randi_range(0,WeaponsMenager.weapons_lvl[randomCategoryWeapon])
	itemCost = weapon_cost[randomCategoryWeapon][WeaponsMenager.weapons_lvl[randomCategoryWeapon]]
	itemCost += randi_range(-itemCost *.2 ,itemCost *.2)

func setItem():
	var PlaceHolderSetText = find_child("Cost", true, true)
	PlaceHolderSetText.text = str(itemCost)
	
	var PlaceHolderSetSkin = find_child("ItemSprite", true, true)
	PlaceHolderSetSkin.texture = load(WeaponsMenager.getWeaponPngWithLevel(randomCategoryWeapon, levelOfWeapon))

func setAll(newItem):
	displayItem = newItem.displayItem
	randomCategoryWeapon = newItem.randomCategoryWeapon
	levelOfWeapon = newItem.levelOfWeapon
	itemCost = newItem.itemCost
	id = newItem.id
	hpCost = newItem.hpCost
	dmgCost = newItem.dmgCost
	addDamage = newItem.addDamage
	addHP = newItem.addHP


func _on_area_2d_body_entered(body):
	if itemCost < Player.gold:
		Player.gold -= itemCost
		if addHP == true || addDamage == true:
			if addHP == true:
				Player.maxHP += 10
				Player.hp += 10
			else:
				Player.dmg += 5
		else:
			#print(randomCategoryWeapon, levelOfWeapon)
			WeaponsMenager.changeShop(randomCategoryWeapon, levelOfWeapon)
			#tutaj zamien bron, jesli gracz ma bron, to tylko zamien, jesli nie to usun tamta
			#emit_signal(changeWaepon)
			pass
		
		queue_free()
		GlobalSignals.itemsInShop[id] = null
		

func setHP():
	var PlaceHolderSetText = find_child("Cost", true, true)
	PlaceHolderSetText.text = str(hpCost)
	var PlaceHolderSetSkin = find_child("ItemSprite", true, true)
	PlaceHolderSetSkin.texture = load("res://Assets/Weapons/forVillageSprites/addHP.png")
	addHP = true
	itemCost = hpCost
	
func setDMG():
	var PlaceHolderSetText = find_child("Cost", true, true)
	PlaceHolderSetText.text = str(dmgCost)
	var PlaceHolderSetSkin = find_child("ItemSprite", true, true)
	PlaceHolderSetSkin.texture = load("res://Assets/Weapons/forVillageSprites/addDMG.png")
	addDamage = true
	itemCost = dmgCost
