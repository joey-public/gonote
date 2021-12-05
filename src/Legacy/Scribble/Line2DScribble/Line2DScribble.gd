extends Scribbles

var StrokeLine:PackedScene = preload("res://src/Drawing/Scribble/Line2DScribble/StokeLine.tscn")
var stroke

#func _ready():
#	self.stroke = StrokeLine.instance()
#	self.add_child(self.stroke)

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
		self.stroke = _create_stoke_line()
		self.add_child(self.stroke)
	elif Input.is_action_pressed("draw"):
#		self.scribble_points.append(get_global_mouse_position())
		self.stroke.add_point(get_global_mouse_position())
		self.trail.add_point(get_global_mouse_position())
	elif Input.is_action_just_released("draw"):
		self.draw_stack.push_back(self.stroke)
#		self.scribble_points.clear()
	else:
		self._remove_trail_point(0)

func _create_stoke_line()->Line2D:
	var s:Line2D = StrokeLine.instance()
	s.width = self.width
	s.default_color = self.color
	s.antialiased = self.anti_a
#	s.texture = self.texture
	return s

