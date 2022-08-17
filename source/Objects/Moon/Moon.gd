#Inherits KinematicBody2D
extends KinematicBody2D
#-------------------------------------------------------------------------------------------------#
#Variables
#Bool Variables
var phaseDict = {
	"flagNew":false,
	"flagWaxCrescent":false,
	"flagFirQuarter":false,
	"flagWaxGibbous":false,
	"flagFull":false,
	"flagWanGibbous":false,
	"flagLasQuarter":false,
	"flagWanCrescent":false
	}
#OnReady Variables
onready var moonSprite: Sprite = $MoonSprite
#Exported Variables
export var rotation_speed = PI
#Animation Nodes
onready var spritePlayer = $AnimationPlayers/SpritePlayer
onready var fxPlayer = $AnimationPlayers/EffectsPlayer
onready var animTree = $AnimationPlayers/AnimationTree
onready var playBack = animTree.get("parameters/playback")
onready var currentState = playBack.get_current_node()
#-------------------------------------------------------------------------------------------------#
#Ready Method
func _process(delta: float) -> void:
	moonOrbit(delta)
#-------------------------------------------------------------------------------------------------#
#Moon Phases
func moonPhase():
	for key in phaseDict.keys():
		phaseDict[key] = false
	var currentPhase = moonSprite.frame
	match(currentPhase):
		0: phaseDict["flagFull"] = true
		1: phaseDict["flagWanGibbous"] = true
		2: phaseDict["flagWanGibbous"] = true
		3: phaseDict["flagLasQuarter"] = true
		4: phaseDict["flagLasQuarter"] = true
		5: phaseDict["flagWanCrescent"] = true
		6: phaseDict["flagWanCrescent"] = true
		7: phaseDict["flagNew"] = true
		8: phaseDict["flagNew"] = true
		9: phaseDict["flagWaxCrescent"] = true
		10: phaseDict["flagWaxCrescent"] = true
		11: phaseDict["flagFirQuarter"] = true
		12: phaseDict["flagFirQuarter"] = true
		13: phaseDict["flagWaxGibbous"] = true
		14: phaseDict["flagWaxGibbous"] = true
		15: phaseDict["flagFull"] = true
#-------------------------------------------------------------------------------------------------#
#Moon Orbit
func moonOrbit(delta):
	get_parent().rotation += rotation_speed * delta
func timedLow():
	get_tree().root.get_node("Debug_Zeuk/Beach/AnimationPlayers/WavePlayer").play("idle_low")
func timedMid():
	get_tree().root.get_node("Debug_Zeuk/Beach/AnimationPlayers/WavePlayer").play("idle_mid")
func timedHigh():
	get_tree().root.get_node("Debug_Zeuk/Beach/AnimationPlayers/WavePlayer").play("idle_high")
