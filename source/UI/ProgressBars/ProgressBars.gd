extends Control
#OnReady Variables
onready var healthUnder = $Health/HealthUnder
onready var healthOver = $Health/HealthOver
onready var healthTween = $Health/HealthTween
#-------------------------------------------------------------------------------------------------#
#Health Updater
#Heal
func healthUpdate_heal(health) -> void:
	healthUnder.value = health
	healthTween.interpolate_property(healthOver, "value", healthOver.value, health,
								   0.4, Tween.TRANS_SINE, Tween.EASE_IN_OUT, 0.4)
	healthTween.start()
	$AnimationPlayer.play("regen")
#Damage
func healthUpdate_damage(health) -> void:
	healthOver.value = health
	healthTween.interpolate_property(healthUnder, "value", healthUnder.value, health,
								   0.4, Tween.TRANS_SINE, Tween.EASE_IN_OUT, 0.4)
	healthTween.start()
#Max Health Updater
func max_healthUpdate(max_health):
	healthOver.max_value = max_health
	healthUnder.max_value = max_health
#-------------------------------------------------------------------------------------------------#
#Animation Player
func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "regen":
		$AnimationPlayer.play("rest")
