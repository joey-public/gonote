extends Node

const refresh_rates:Dictionary = {
	"draw_rate":90,
	"pan_rate":60,
	"slow_rate":30,
}
var display_res

var draw_stack:Array = []
var undo_stack:Array = []

signal redraw_stack(f,t)

# Called when the node enters the scene tree for the first time.
func _ready():
	Engine.target_fps = 120
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	display_res = self.get_viewport().get_visible_rect().size

func _process(_delta):
	pass
#	var temp = display_res
#	display_res = get_viewport().get_visible_rect().size
#	if temp != display_res:
#		print(display_res)
#	temp = display_res

#func remove_from_draw_stack(i:int):
#	self.draw_stack.remove(i)
#	self.redraw_stack(i-1,i+1)
#
#func redraw_stack(from:int=0,to:int=-1):
#	self.form = from
#	if to ==-1: self.to = self.draw_stack.size()
#	self.update()
#
#
#func _draw():
#	for i in range(from,to):
#		self.draw_stack[i].draw(self)
