extends Node2D

export var color:Color = Color.black
export var width:float = 1
export var anti_a:bool = true


var scribble_points:Array = []
var draw_stack:Array = []

onready var pos = self.get_global_mouse_position()

func _process(_delta):
	if self.visible: 
		if Input.is_action_pressed("draw"):
#			self.scribble.add_point(self.position)
			self.scribble_points.append(get_global_mouse_position())
			self.update()
		elif Input.is_action_just_released("draw"):
			self.draw_stack.push_back(PoolVector2Array(self.scribble_points))
			self.scribble_points.clear()


func _draw():
	if self.scribble_points.size() > 2:
		self.draw_polyline(self.scribble_points,self.color,self.width,self.anti_a)
	for scribble in self.draw_stack:
		if scribble.size() >2:
			self.draw_polyline(scribble,self.color,self.width,self.anti_a)
