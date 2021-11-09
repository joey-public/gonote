extends Node


var display_res


# Called when the node enters the scene tree for the first time.
func _ready():
	print("hello!")
	display_res = self.get_viewport().get_visible_rect().size

func _process(_delta):
	pass
#	var temp = display_res
#	display_res = get_viewport().get_visible_rect().size
#	if temp != display_res:
#		print(display_res)
#	temp = display_res

