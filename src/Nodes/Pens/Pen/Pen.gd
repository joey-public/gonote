#Base Class for all Pens. 
#Pens are Responsible generating stroke data and pushing to the global draw_stack
class_name Pen
extends Node2D

var draw_xform:Transform2D
var data_xform:Transform2D
var stroke_data:PoolVector2Array
var active = false
var bbox:Rect2
var id:int

var width:float = 1.5
var color:Color = Color.black
var anti_a:bool = true
var texture:Texture


func _ready():
	pass


func _process(delta):
	if not(self.active):return 
	self.scribble(delta)


func scribble(_delta):
	pass
