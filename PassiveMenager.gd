extends Node

var churchItems = []
var varietyItems = []
var maxLevelForChurchUpgrades = 20
var churchSprites = ["res://Assets/Weapons/forVillageSprites/health.png","res://Assets/Weapons/forVillageSprites/attack_dmg.png","res://Assets/Weapons/forVillageSprites/movement_speed.png"]
var varietySprites = ["res://Assets/Weapons/forVillageSprites/Ghost_Compass.png", "res://Assets/Weapons/forVillageSprites/Hanamusubi.png","res://Assets/Weapons/forVillageSprites/health.png", "res://Assets/Weapons/forVillageSprites/O_mamori.png"]

var varietyItemsCost = [200, 1500, 150, 300]
var churchItemCosts = []

func _init():
	Village.loadItems(Village.churchItemNames, churchItems)
	Village.loadItems(Village.varietyShopItemNames, varietyItems)
	setChurchItemCosts()
	addStatsToPlayer()

func setChurchItemCosts():
	for i in range(maxLevelForChurchUpgrades):
		churchItemCosts.append(i * 20)


func addStatsToPlayer():
	Player.maxHP = Player.baseHP + churchItems[0] * 10
	#Player.hp = Player.maxHP
	Player.dmg = Player.baseDmg + churchItems[1] * 5
	Player.MAX_SPEED = Player.BASE_SPEED + churchItems[2] * 3 
	
	
	
