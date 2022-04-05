#Base Class for all Pens. 
#Pens are Responsible generating stroke data and pushing to the global draw_stack
class_name Pen
extends Node2D


func _ready():
	pass


func _process(delta):
	if not(self.active):return 
	self.scribble(delta)


func scribble(_delta):
	pass
