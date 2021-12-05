extends TextureButton

var button_count = 5
var r = 15


# Called when the node enters the scene tree for the first time.
func _ready():
	self.update()

func _draw():
	var pos = Vector2(self.get_rect().size.x,r+1)
	for i in button_count:
		draw_arc(pos,15,PI/2,3*PI/2,25,Color.black,1,true)
		pos.y += 150/button_count -1
#	draw_arc(pos,15,PI/2,3*PI/2,25,Color.black,1,true)
	
