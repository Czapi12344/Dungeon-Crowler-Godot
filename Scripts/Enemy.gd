extends Node

class_name Enemy

var sprite = "res://icon.svg"

var health = 100.0
var damage = 30
var armor = 1
var speed = 3


func dealDamage(damage):
	if(damage - (armor + 1) > damage * 0.2):
		health -= damage - (armor + 1)
	else:
		health -= damage * .2
	
	if health <= 0:
		die()
		
func getHealth():
	return health

func getDamage():
	return damage

func setHealth(newHealth):
	health = newHealth
	
func setDamage(newDamage):
	damage = newDamage

func die():
	queue_free()

func setSprite(pathToSprite):
	sprite = pathToSprite
