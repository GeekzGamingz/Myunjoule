extends Node
#------------------------------------------------------------------------------#
#Variables
var actions = {
	LEFT = "ui_left",
	RIGHT = "ui_right",
	DOWN = "ui_down",
	UP = "ui_up",
	GRAPPLE = "ui_grapple"
}
#Constants
const TILE_SIZE = 24
#OnReady Variables
onready var MYUN = get_tree().root.get_node("Myunjoule")
onready var PLAYER = get_tree().root.get_node("Myunjoule/YSort/WorldKinematics/Player")
onready var EXPO = get_tree().root.get_node("Myunjoule/YSort/WorldKinematics/Expo")
onready var UI = get_tree().root.get_node("Myunjoule/UserInterface")
#Zones
onready var BEACH = get_tree().root.get_node("Myunjoule/YSort/Zones/Beach")
onready var TOWN = get_tree().root.get_node("Myunjoule/YSort/Zones/Town")
onready var LAB = get_tree().root.get_node("Myunjoule/YSort/Zones/Lab")
