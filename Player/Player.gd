extends CharacterBody2D


@export var MAX_SPEED = 300
@export var BASE_SPEED = 300
@export var ACCE = 1500
@export var FRICTION = 1200
@onready var axis = Vector2.ZERO

@export var speed :Vector2
@export var DASH_CD = 2
@export var DASH_SPEED = 3000 
@export var dashing = false
@export var canDash = true

@export var hp = 100
@export var maxHP = 100
@export var baseHP = 100

@export var gold = 0

@export var dmg = 10
@export var baseDmg = 10

@export var atackspeed = 2

@export var armor = 0;


var weapon_TSCN  = "res://Weapons/weaponStick.tscn"
var bullet_TSNC  = "res://Weapons/Projectiles/bulletFireBall2.tscn"
var weapon_PNG   = "res://Assets/Weapons/Stick.png"

var isWeapon = false

func changeWeapon( _weapon_TSCN , _bullet_TSCN , _weaponPNG):
	
	if( isWeapon !=false ):
		delteWeapon()
	isWeapon = true
	
	var weapon = load(_weapon_TSCN).instantiate()
	weapon.setWeaponConfig(dmg , atackspeed , _bullet_TSCN )
	weapon.setSprite(_weaponPNG)
	weapon.position = $WeaponMarker2d.position
	weapon.rotation_degrees = rotation_degrees	
	
	self.get_child(0).add_child(weapon)	
	
func delteWeapon():
	self.get_child(0).get_child(0).queue_free()


func _ready():
	changeWeapon(weapon_TSCN, bullet_TSNC , weapon_PNG)
	
	
func _physics_process(delta):
	move(delta)
	animation()

func teleport():
	pass
	

func animation():
	if( Input.is_action_pressed("moveRight")  ):
		$AnimationPlayer.play("right_move_animation")	
		
	elif( Input.is_action_pressed("moveLeft")  ):
		$AnimationPlayer.play("left_move_animation")	
		
	elif( Input.is_action_pressed("moveUp")  ):
		$AnimationPlayer.play("right_move_animation")	
		
	elif( Input.is_action_pressed("moveDown")  ):
		$AnimationPlayer.play("left_move_animation")	
	else :
		$AnimationPlayer.play("idle")	
	
	
func dash():
	
	print( "dash!")
	velocity = axis.normalized( ) * DASH_SPEED	
	canDash = false
	dashing = true
	
	await get_tree().create_timer( DASH_CD ).timeout
	
	canDash = true;
	dashing = false;
	
	
	
func getInputAxis():

	axis.x = int( Input.is_action_pressed("moveRight"))  - int( Input.is_action_pressed("moveLeft")) 
		
	axis.y = int( Input.is_action_pressed("moveDown"))  - int( Input.is_action_pressed("moveUp")) 
	
	return axis
	
func move(delta):
	axis = getInputAxis()
		
	if axis == Vector2.ZERO:
	
		applyFriction( FRICTION * delta)
		
	else:
		if( Input.is_action_pressed("dash") and canDash  ):
			dash()
		else:
			applyMovement( axis * ACCE * delta )
		
	

	move_and_slide()


func applyFriction( value):
	
	if( velocity.length() > value):
		velocity -= velocity.normalized() * value
	
	else:
		velocity = Vector2.ZERO
		
		
func applyMovement( acc):
	
	velocity += acc

	velocity = velocity.limit_length( MAX_SPEED )	
	


func recive_dmg(baseDMG):
	var dmg = baseDMG  - armor 
	
	self.hp -= dmg


func _on_hurt_box_area_entered(hitbox):
	recive_dmg(hitbox.DMG)
	print(  self.hp)	

