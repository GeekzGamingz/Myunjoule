#Handles 2D Bodies
extends KinematicBody2D
class_name Actor
#-------------------------------------------------------------------------------------------------#
#Constants
const FLOOR_NORMAL = Vector2.UP
const SLOPE_SLIDE_STOP = 25.0
var motion = Vector2.ZERO
var walk_speed = 3.5 * Globals.TILE_SIZE
var run_speed = 7 * Globals.TILE_SIZE
var max_speed = walk_speed

export(float, 0, 500, 0.01) var gravity           := 300.0
export(float, 0, 1, 0.01)  var max_acceleration   := 0.5
export(float, 0, 1, 0.01)  var acceleration_step  := 0.15
export(float, 0, 1, 0.01)  var friction           := 0.6
export(float, 0, 1, 0.005) var friction_step      := 0.235
