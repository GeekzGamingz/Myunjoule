extends KinematicBody2D
class_name Actor
#------------------------------------------------------------------------------#
#Variables
#Movement
var motion = Vector2()
var move_speed = 3.5 * G.TILE_SIZE
var boost_speed = 7 * G.TILE_SIZE
var max_speed = move_speed
var gravity = boost_speed
