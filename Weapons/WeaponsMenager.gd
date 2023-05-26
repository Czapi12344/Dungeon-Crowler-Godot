extends Node

var sword_png = ["res://Assets/Weapons/sword_1.png", "res://Assets/Weapons/sword_2.png", "res://Assets/Weapons/sword_3.png"]
var wand_png = ["res://Assets/Weapons/wand_1.png", "res://Assets/Weapons/wand_2.png", "res://Assets/Weapons/wand_3.png" ]
var axe_png = [ "res://Assets/Weapons/AXE_1.png", "res://Assets/Weapons/Axe_gay.png", "res://Assets/Weapons/Axe_straight.png"]
var hammer_png = [ "res://Assets/Weapons/Hammer_gay.png", "res://Assets/Weapons/Hammer_straight.png", "res://Assets/Weapons/hammer_3.png"]
var crossbow_png = ["res://Assets/crossbow_1.png", "res://Assets/crossbow_2.png", "res://Assets/crossbow_3.png"]
var chestPlate = ["res://Assets/Weapons/forVillageSprites/armor_1.png", "res://Assets/Weapons/forVillageSprites/armor_2.png", "res://Assets/Weapons/forVillageSprites/armor_3.png"]

var weapons2d = [sword_png , wand_png , axe_png , hammer_png , crossbow_png, chestPlate]

# to do zmiany - we wiosce lepiej 2d Array

				

var weapon_TSCN   = [ "res://Weapons/weaponSword.tscn"  , "res://Weapons/weaponWand.tscn" , "res://Weapons/weaponAxe.tscn" ,"res://Weapons/weaponHammer.tscn" , "res://Weapons/weaponCrossBow.tscn"  ]


# dorobić Projectiles do każdej borni lub tylko do typu 
var bullet_TSCN   = ["res://Weapons/Projectiles/bulletWand.tscn" , 
"res://Weapons/Projectiles/bulletWand2.tscn", 
"res://Weapons/Projectiles/bullet_shadered.tscn",
 "res://Weapons/Projectiles/bulletWand.tscn" , 
"res://Weapons/Projectiles/arrow.tscn",
 "res://Weapons/Projectiles/arrow.tscn"]

var weapon_cost  = [[ 100 , 300 , -1],
					[ 100 , 750 , -1],
					[ 75 , 150 , -1],
					[ 120 , 500 , -1],
					[ 80 , 850 , -1],
					[ 100 , 350 , -1]]

var currnetWeapon = 0
var maxLvl = 2 #lvl 3
var weapons_lvl = []
var weapons_Cost = [0,0,0,0,0,0,0]

## do testowanie 0 - 4 zmieniać w inspektorze
@export var temp = 2;


func _process(_delta):
	
	if( Input.is_action_pressed("WeaponTest") ):
		setWeapon( temp  )

func setWeapon( weaponIndex):
	currnetWeapon = weaponIndex
	change()

func changeShop(weaponIndex, weaponLvl):
	Player.changeWeapon( weapon_TSCN[weaponIndex] , bullet_TSCN[weaponIndex] , weapons2d[weaponIndex][weaponLvl] )

func change():
	Player.changeWeapon(weapon_TSCN[currnetWeapon], bullet_TSCN[currnetWeapon], weapons2d[currnetWeapon][weapons_lvl[currnetWeapon]]  )

func getCurrentWeaponPNG():
	return weapons2d[currnetWeapon][ weapons_lvl[currnetWeapon]]
	
func getWeaponPng(indexFirst):
	return weapons2d[indexFirst][weapons_lvl[indexFirst]]
	
func getWeaponPngWithLevel(indexFirst, weapons_lvl):
	return weapons2d[indexFirst][weapons_lvl]


func _init():
	Village.loadItems(Village.blacksmithItemNames, weapons_lvl)
	#print(weapons_lvl)
