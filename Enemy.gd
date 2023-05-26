extends Node

class_name Enemy

var sprite = "res://icon.svg"
var health = 100.0
var damage = 30
var armor = 1
func dealDamage(damage):
	health -= damage - (armor + 1)
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
