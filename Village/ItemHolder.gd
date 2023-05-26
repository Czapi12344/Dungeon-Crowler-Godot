extends Node2D


# Define the function that will be called when the node is clicked
var idOfItemInArray
var node
var PlaceHolderSetText
var PlaceHolderSetText2
var id # wheather item belongs to blacksmith or church and so on 0 - blacksmith, 1 - church
var itemOnDisplay
var PlaceHolderSetSkin
var item_level = 0

func setWeapon():
	var text
	item_level = WeaponsMenager.weapons_lvl[idOfItemInArray]
	if(WeaponsMenager.weapon_cost[idOfItemInArray][item_level] == -1):
		text = "Bought"
	else:
		text = str(WeaponsMenager.weapon_cost[idOfItemInArray][item_level]) + ' monet'
		
	setText(text)
	
func setVariety():
	var text
	if PassiveMenager.varietyItems[idOfItemInArray] == 1:
		text = str('Bought')
	else:
		text = str(PassiveMenager.varietyItemsCost[idOfItemInArray]) + ' monet' 
	setText(text)
	
	
func setChurch():
	item_level = PassiveMenager.churchItems[idOfItemInArray]
	var text
	if item_level == 20:
		text = str('Bought')
	else:
		text = str(PassiveMenager.churchItemCosts[item_level]) + ' monet'
	setText(text)


func lvl_up():
	if id == 0:
		if WeaponsMenager.weapons_lvl[idOfItemInArray] + 1 < WeaponsMenager.weapon_cost[idOfItemInArray].size() && Player.gold >= WeaponsMenager.weapon_cost[idOfItemInArray][item_level]:
			Player.gold -= WeaponsMenager.weapon_cost[idOfItemInArray][item_level]
			WeaponsMenager.weapons_lvl[idOfItemInArray] += 1
	elif id == 1:
		if PassiveMenager.churchItems[idOfItemInArray]  < PassiveMenager.maxLevelForChurchUpgrades && Player.gold >= PassiveMenager.churchItemCosts[item_level]:
			Player.gold -= PassiveMenager.churchItemCosts[item_level]
			PassiveMenager.churchItems[idOfItemInArray]  += 1
	elif id == 2:
		if PassiveMenager.varietyItems[idOfItemInArray]  == 0 && Player.gold >= PassiveMenager.varietyItemsCost[idOfItemInArray]:
			Player.gold -= PassiveMenager.varietyItemsCost[idOfItemInArray]
			PassiveMenager.varietyItems[idOfItemInArray]  = 1
	Village.playerBoughtAnItem()
	PassiveMenager.addStatsToPlayer()
	my_function()
	
func my_function():
	if idOfItemInArray == null:
		return
	if id == 0:
		setWeapon()
	elif id == 1:
		setChurch()
	elif id == 2:
		setVariety()


func setText(text):
	PlaceHolderSetText = find_child("Bought", true, true)
	PlaceHolderSetText.text = text
	
	PlaceHolderSetText = find_child("Cost", true, true)
	PlaceHolderSetText.text = str(item_level)
	PlaceHolderSetText.visible = true
	if id == 2:
		PlaceHolderSetText.visible = false
	PlaceHolderSetSkin = find_child("Item", true, true)
	
	if itemOnDisplay == null:
		PlaceHolderSetSkin.visible = false
		return
	if id == 0:
		setNewSkin()
	PlaceHolderSetSkin.texture = load(itemOnDisplay)
	

func setNewSkin():
	itemOnDisplay = WeaponsMenager.getWeaponPng(idOfItemInArray)
	
func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		lvl_up()
