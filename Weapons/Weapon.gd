extends Node2D

var bought = false
@export var bullet_TSNC : String ="res://Weapons/Projectiles/bulletFireBall2.tscn"
@export var dmg : int  = 5 
@export var atackspeed : float = 10

var BULLET_SPEED = 300
var FIRE_CD : float = atackspeed
var can_fire = true

func setWeaponConfig( _dmg , _atackspeed , _bullet_TSNC ):
	atackspeed = _atackspeed
	dmg = _dmg
	bullet_TSNC = _bullet_TSNC
	FIRE_CD = 1. / atackspeed

func setSprite(sprite):
	$SpriteWeapon.texture = load(sprite)

func _process(_delta):

	look_at(get_global_mouse_position())	
	
	if (Input.is_action_pressed("fire") and can_fire) :
		shootBullet()


func shootBullet():
	
	var bullet = load(bullet_TSNC).instantiate()
	bullet.position = $BulletPoint.get_global_position()
	bullet.dmg = dmg
	bullet.rotation_degrees = rotation_degrees
	bullet.apply_impulse(Vector2(BULLET_SPEED  , 0).rotated(rotation)) 
	
	get_tree().get_root().add_child( bullet)
	
	can_fire = false
	
	await get_tree().create_timer( FIRE_CD ).timeout
	
	can_fire = true
