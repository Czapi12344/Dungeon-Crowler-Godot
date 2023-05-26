extends Node


var entered = false
var teleportToWhere
var amount = 0
var AMOUNT_OF_TIME_UNTIL_WILL_BE_TRANSPORTED_TO_ANOTHER_ROOM = 0.3
var id #0 przenosi do 1, 1 do 0, 2 do 3, 3 do 2, chyba, ale dziala
var instant_usable_teleport = true # mozna sjkorzystac z tego teleportu od razu po przeteleportowaniu sie do innego pokoju
var can_teleport = false

@onready var timer = $Timer
func _ready():
	timer = Timer.new()
	timer.wait_time = AMOUNT_OF_TIME_UNTIL_WILL_BE_TRANSPORTED_TO_ANOTHER_ROOM
	timer.connect("timeout", teleport_open)
	add_child(timer)
	timer.start()
	
func _process(_delta):
	$AnimationPlayer.play("portal_down_anim")
	
	


func teleport_open():
	can_teleport = true
	
func _on_body_entered( _body: CharacterBody2D): # idk czy nie bedzie trzeba zmienic, w sensie czy potwory ich nie beda uruchamiac 
	if _body.is_in_group("player") and can_teleport:
		teleport_to_another_room()
		

		
#func _on_body_entered(body: CharacterBody2D): # idk czy nie bedzie trzeba zmienic, w sensie czy potwory ich nie beda uruchamiac 
#	if !instant_usable_teleport:
#		return
#	teleport_to_another_room()
#	if amount == 0:
#		entered = true
#		amount += 1
#	if entered == true:
#		timer = Timer.new()
#		timer.wait_time = AMOUNT_OF_TIME_UNTIL_WILL_BE_TRANSPORTED_TO_ANOTHER_ROOM
#		timer.connect("timeout", teleport_to_another_room)
#		add_child(timer)
#		timer.start()
#	else:
#		timer.stop()
#		timer.queue_free()
#		timer = null
#		entered = true
	
func teleport_to_another_room():
	FloorManager.changeRoom(teleportToWhere, id)
	entered = false


func _on_body_exited(_body: CharacterBody2D):
	pass
#	entered = true
#	instant_usable_teleport = true
#	if timer:
#		timer.stop()
	#	timer.queue_free()
	#	timer = null
