extends Control
#OnReady Variables
onready var energyUnder = $Energy/EnergyUnder
onready var energyOver = $Energy/EnergyOver
onready var energyTween = $Energy/EnergyTween
#-------------------------------------------------------------------------------------------------#
#energy Updater
#Heal
func energyUpdate_charge(energy) -> void:
	energyUnder.value = energy
	energyTween.interpolate_property(energyOver, "value", energyOver.value, energy,
								   0.4, Tween.TRANS_SINE, Tween.EASE_IN_OUT, 0.4)
	energyTween.start()
	$AnimationPlayer.play("regen")
#Damage
func energyUpdate_drain(energy) -> void:
	energyOver.value = energy
	energyTween.interpolate_property(energyUnder, "value", energyUnder.value, energy,
								   0.4, Tween.TRANS_SINE, Tween.EASE_IN_OUT, 0.4)
	energyTween.start()
#Max Energy Updater
func max_energyUpdate(max_energy):
	energyOver.max_value = max_energy
	energyUnder.max_value = max_energy
#-------------------------------------------------------------------------------------------------#
#Animation Player
func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "regen":
		$AnimationPlayer.play("rest")
