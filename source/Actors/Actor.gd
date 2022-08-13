#Handles 2D Bodies
extends KinematicBody2D
class_name Actor
#-------------------------------------------------------------------------------------------------#
#Constants
const FLOOR_NORMAL = Vector2.UP
const SLOPE_SLIDE_STOP = 25.0
var motion = Vector2()
var gravity = 2
var walk_speed = 3.5 * Globals.TILE_SIZE
var run_speed = 7 * Globals.TILE_SIZE
var max_speed = walk_speed
