extends Node

const refresh_rates:Dictionary = {
	"draw_rate": 90,
	"pan_rate":60,
	"slow_rate":30,
}
var display_res


# Called when the node enters the scene tree for the first time.
func _ready():
	Engine.target_fps = 30
	display_res = self.get_viewport().get_visible_rect().size

func _process(_delta):
	pass
#	var temp = display_res
#	display_res = get_viewport().get_visible_rect().size
#	if temp != display_res:
#		print(display_res)
#	temp = display_res

