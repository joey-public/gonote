extends Scribbles


var size:Vector2 = Vector2(2,2)
var rect = Rect2(Vector2.ZERO,self.size)


func scribble(delta):
	self.update()

func _draw():
	self.rect.position = get_global_mouse_position() - self.rect.size/2
	self.draw_rect(self.rect,Color.black,true,1)	
#	print(Globals.draw_stack)
	for i in Globals.draw_stack.size():
		var stroke = Globals.draw_stack[i]
#		print(stroke)
		if stroke.bbox.intersects(self.rect):
#			print("True")
			if Input.is_action_pressed("draw"):
				Globals.undo_stack.push_front(stroke)
				Globals.draw_stack.remove(i)
				Globals.emit_signal("redraw_stack")
#				Globals.redraw_stack()
				return 
			else:
				var color = Color.chartreuse
				self.draw_rect(stroke.bbox,color,false,1)
				color.a = 0.1
				self.draw_rect(stroke.bbox,color,true,1)
