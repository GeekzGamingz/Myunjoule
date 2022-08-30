extends Position2D
#------------------------------------------------------------------------------#
#Variables
#Exported Variables
export var revolution = -PI
#Bool Variables
var phase = {
	"NEW":false,
	"WAX_CRES":false,
	"FIR_QUAR":false,
	"WAX_GIBB":false,
	"FULL":false,
	"WAN_GIBB":false,
	"LAS_QUAR":false,
	"WAN_CRES":false,
}
#OnReady Variables
#------------------------------------------------------------------------------#
func _process(delta: float) -> void:
	moonOrbit(delta)
#------------------------------------------------------------------------------#
#Moon Phases
func moonPhase():
	for key in phase.keys():
		phase[key] = false
	var currentPhase = self.frame
	match(currentPhase):
		0: phase["NEW"] = true
		1: phase["WAX_CRES"] = true
		2: phase["FIR_QUAR"] = true
		3: phase["WAX_GIBB"] = true
		4: phase["FULL"] = true
		5: phase["NEW"] = true
		6: phase["NEW"] = true
		8: phase["NEW"] = true
#Moon Orbit
func moonOrbit(delta):
	self.rotation += revolution * delta
#------------------------------------------------------------------------------#
