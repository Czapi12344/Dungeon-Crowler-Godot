extends RigidBody2D

@export var time : float = 1

@onready var hitbox = $HitBox
var dmg = 10


func _ready():
	
	hitbox.dmg  = dmg
	
	var timer = Timer.new()
	timer.wait_time = time
	timer.connect("timeout" , clearBullets )
	add_child(timer)
	timer.start()
	
	GlobalSignals.connect("clearBullets" , clearBullets )	
	
	
func clearBullets():
	queue_free()
	


func _on_disapere_body_entered(body):
	if( !body.is_in_group("player") ):
		queue_free()


func _on_hit_box_area_entered(area):
	pass # Replace with function body.
