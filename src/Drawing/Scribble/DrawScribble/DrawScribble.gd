extends Scribbles

enum DRAW_MODES {POLYLINE,TEXTURE}
var drawfuncs:Dictionary = {
	DRAW_MODES.POLYLINE: funcref(self,"_polyline_draw"),
	DRAW_MODES.TEXTURE: funcref(self,"_texture_draw"),
}
var draw_mode = DRAW_MODES.POLYLINE


func _draw():
	self.drawfuncs[self.draw_mode].call_func()

func _input(event):
	if event.is_action_pressed("Increase_pen_size"):
		self.width += 1
		print(self.width)
	if event.is_action_pressed("decrease_pen_size"):
		self.width -= 1
		print(self.width)


func scribble(_delta):
	if Input.is_action_just_pressed("draw"):
		self._clear_trail_points()
	elif Input.is_action_pressed("draw"):
		self.scribble_points.append(get_global_mouse_position())
		self.trail.add_point(get_global_mouse_position())
		self.update()
	elif Input.is_action_just_released("draw"):
		self.draw_stack.push_back(Scribbles.Stroke.new(self))
		self.scribble_points.clear()
	else:
		self._remove_trail_point(0)


func _polyline_draw():
	if self.scribble_points.size() > 2:
		self.draw_polyline(self.scribble_points,self.color,self.width,self.anti_a)
	for stroke in self.draw_stack:
		if stroke.mouse_points.size() >2:
			self.draw_polyline(stroke.mouse_points,stroke.color,stroke.width,stroke.anti_a)


func _texture_draw():
	pass

func _circle_draw():
	pass
