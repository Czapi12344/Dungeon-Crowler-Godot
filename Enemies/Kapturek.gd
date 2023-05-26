extends CharacterBody2D

@export var hp = 100
@export var DMG = 10
@export var armor = 0 
@export var toughness = 0 
@export var current_state = states.IDLE
@export var SPEED = 5

@onready var hurtbox = $HurtBox
@onready var hitbox = $HitBox
	
var friction = 0.2
var steer = Vector2.ZERO
var spawn_point 
const MAX_SPEED = 0.7

var goldDrop = 100

enum states{
	IDLE,
	CHAREGE,
	CHAREGE_HIT,
	WANDER,
	SPAWN_WANDER,
}

func _ready():

	spawn_point = global_position

	pass	
	
	
func _physics_process(_delta):
		
	if( current_state == states.WANDER ):
		if randi_range(1,100) > 98:
			wander()
		else:
			apply_velocity()
		pass
				
	if( current_state == states.SPAWN_WANDER ):
		spawn_wander()
	if( current_state == states.CHAREGE ):
		charge()
	if( current_state == states.CHAREGE_HIT ):
		charge_hit()
	if ( current_state == states.IDLE):
		if randi_range(1,100) > 98:
			wander()
		else:
			apply_velocity()
		pass
	
	var target_velocity =  steer  * SPEED
	
	velocity += ( target_velocity - velocity) * friction
	
	velocity = velocity.limit_length( MAX_SPEED )	
	
	move_and_collide(velocity)
	

var velocity2 = Vector2.ZERO
	
func apply_velocity():
	velocity = velocity2
	
func wander():
	
	var direction =  Vector2( randf_range(-1,1) , randf_range(-1,1)  )
	var distance = randf_range( 0 , 20)
		
	var to_spawn = global_position.direction_to(spawn_point)
	
	var target = spawn_point + direction * distance

	
	velocity2 = ( target  - position ).normalized() * SPEED
 

func idle():	 
	var dir = Vector2( 0 ,0 )
	steer =  dir.normalized()
var dir2 = Vector2(0, 0)
func charge():
	
	var new_pos = global_position.direction_to(Player.global_position)
		
	var distance = Player.global_position.distance_to(position)
	
	var dir = Vector2( 0, 0)
	
	
	if randi_range(1,100) > 50:
		dir = setDir2(dir2)
	else:
		dir = dir2
	if randi_range(1,100) > 95:
		if( int(distance + randi_range( -50,10 )) > 100):
			dir = Vector2(new_pos.x , new_pos.y 	)
			dir2 = dir
		else:
			dir = Vector2( -new_pos.x , -new_pos.y 	)
			dir2 = dir
	

	steer = dir.normalized()
	
func setDir2(dir2):
	if dir2.x > dir2.y:
		dir2.y += .4
		dir2.x -= .4
	else:
		dir2.y = .4
		dir2.x += .4
	return dir2	

func charge_hit():
	var new_pos = global_position.direction_to(Player.global_position)
	
	var dir = Vector2(new_pos.x , new_pos.y 	)
	steer = dir.normalized() 
	
func spawn_wander():
	var to_spawn = global_position.direction_to(spawn_point)
	var dir = Vector2(to_spawn.x , to_spawn.y)
	steer = dir.normalized() 	
	

func animation():
	$AnimatedSprite2D.play("default")	


func _on_detection_range_body_entered(body):
	
	if	body.is_in_group("player") && current_state != states.CHAREGE_HIT :
		current_state = states.CHAREGE
	pass

func _on_detection_range_body_exited(body):
	
	if	body.is_in_group("player") && current_state == states.CHAREGE:
		current_state = states.IDLE
	pass
	



func die():
	queue_free()
	

func recive_dmg(baseDMG):
	var dmg = baseDMG  - armor 
	
	self.hp -= dmg


func _on_hurt_box_area_entered(hitbox):
	
	recive_dmg(hitbox.dmg)
	current_state = states.CHAREGE_HIT
	hitbox.get_parent().clearBullets()
	if( self.hp <= 0):
		Player.gold += goldDrop + randi_range(-10, 10)
		$AnimatedSprite2D.play("die")




func _on_animated_sprite_2d_animation_finished():
	print( $AnimatedSprite2D.name)
	die()
