extends CanvasLayer




func _ready():
	$Control/ProgressBar.max_value = Player.maxHP;
	uppdateGui()

	
func uppdateGui():
	$Control/currentHPText.text = str(Player.hp) + " / " + str(Player.maxHP)
	$Control/coinsCount.text = str(Player.gold)
	
	$Control/ProgressBar.value = Player.hp
	$Control/weaponSlot/weaponIcon.texture = load(  WeaponsMenager.getCurrentWeaponPNG() )
	
func _process(delta):	
	uppdateGui()
