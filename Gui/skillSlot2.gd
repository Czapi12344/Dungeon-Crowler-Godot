extends ReferenceRect

@onready
var time_label = $Counter

@export
var cooldown = 1.0


#func _ready():
#	$TimerSkill2.wait_time = cooldown
#	time_label.hide()
#	$Sweep.texture_progress = $SkillIcon2.texture.resourcepath()
#	$Sweep.value = 0
#	set_process(false)
#
#func _process(delta):
#	time_label.text = "%3.1f" % $TimerSkill2.time_left
#	$Sweep.value = int(($TimerSkill2.time_left / cooldown) * 100)
#
#func _on_Timer_timeout():
#	$Sweep.value = 0
#	time_label.hide()
#	set_process(false)
