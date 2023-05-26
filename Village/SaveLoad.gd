extends Node

var blacksmithItemNames = ['SWORD', 'WAND', 'AXE', 'HAMMER', 'CROSSBOW', 'CHESTPLATE']

var churchItemNames = ['HP', 'DMG', 'MOVESPEED']
var varietyShopItemNames = ['SPIRIT COMPASS','HANAMUSUBI','SECRET SEEKER', 'O_MAMORI']

var gold = "gold"

# HANAMASUBI - WIECEJ GOLDA
# SECRET SEEKER - JAK MASZ ITEM I PODEJDZIESZ DO KAMYKA ODKRYWASZ TAJEMNE PRZEJSCIE I KAMYK ZNIKA
# O_MAMORI - WSKRZESZA 1 RAZ
var MAX_LEVEL = 20

var weapons = []

func playerBoughtAnItem():	
	
	var config = ConfigFile.new()
	
	for i in range(len(blacksmithItemNames)):
		
		config.set_value("user_data", blacksmithItemNames[i], WeaponsMenager.weapons_lvl[i])
	
	for i in range(len(churchItemNames)):
		
		config.set_value("user_data", churchItemNames[i], PassiveMenager.churchItems[i])
		
	for i in range(len(varietyShopItemNames)):
		config.set_value("user_data", varietyShopItemNames[i], PassiveMenager.varietyItems[i])
	
	config.set_value("user_data", gold ,Player.gold)
	
	config.save("user_data.cfg")

func loadItems(items, items2):

	
	var config = ConfigFile.new()
	
	if config.load("user_data.cfg") == OK:
	
		for item in items:
			var item_level = config.get_value("user_data", item, 0)
			items2.append(item_level)
	
	return items

func _ready():
	var config = ConfigFile.new()
	if config.load("user_data.cfg") == OK:
		Player.gold = config.get_value("user_data", gold, 0)
	Player.hp = Player.maxHP
#func _init():
	#clearConfig(blacksmithItems)
	
func clearConfig(nameOfArray):
	var config = ConfigFile.new()
	if config.load("user_data.cfg") == OK:
		for i in range(len(nameOfArray)):
			config.set_value("user_data", nameOfArray[i], 0)
		config.save("user_data.cfg")
