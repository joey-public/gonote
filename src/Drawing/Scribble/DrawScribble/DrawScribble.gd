extends Scribbles

enum DRAW_MODES {POLYLINE,TEXTURE,MULTILINE,LINE,CIRCLE}
var drawfuncs:Dictionary = {
	DRAW_MODES.POLYLINE: funcref(self,"_polyline_draw"),
	DRAW_MODES.TEXTURE: funcref(self,"_texture_draw"),
	DRAW_MODES.MULTILINE: funcref(self,"_multiline_draw"),
	DRAW_MODES.LINE: funcref(self,"_line_draw"),
	DRAW_MODES.CIRCLE: funcref(self,"_circle_draw"),
}
var draw_mode = DRAW_MODES.POLYLINE

var _pen = null
var _prev_mouse_pos = Vector2()

func _ready():
	var img = Image.new()
	img.load("res://NoteTaking.png")
	img.resize(self.width*2,self.width*2)
	self.texture = ImageTexture.new()
	self.texture.create_from_image(img)

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
		if self.width>1:draw_circle(self.scribble_points[0],self.width,self.color)
		self.draw_polyline(self.scribble_points,self.color,self.width,self.anti_a)
		if self.width>1:draw_circle(self.scribble_points[self.scribble_points.size()-1],self.width/2,self.color)
	for stroke in self.draw_stack:
		if stroke.mouse_points.size() >2:
			if stroke.width>1:self.draw_circle(stroke.mouse_points[0],stroke.width/2,stroke.color)
			self.draw_polyline(stroke.mouse_points,stroke.color,stroke.width,stroke.anti_a)
			if stroke.width>1:self.draw_circle(stroke.mouse_points[stroke.mouse_points.size()-1],stroke.width/2,stroke.color)


func _multiline_draw():
	if self.scribble_points.size() > 2:
		self.draw_multiline(self.scribble_points,self.color,self.width,self.anti_a)
	for stroke in self.draw_stack:
		if stroke.mouse_points.size() >2:
			self.draw_multiline(stroke.mouse_points,stroke.color,stroke.width,stroke.anti_a)

func _texture_draw():
	if self.scribble_points.size() > 2:
		for point in self.scribble_points:
			self.draw_texture(self.texture,point,self.color,null)
	for stroke in self.draw_stack:
		if stroke.mouse_points.size() >2:
			for point in stroke.mouse_points:
				self.draw_texture(self.texture,point,self.color,null)
	

func _circle_draw():
	pass

##SUPER BROKEN
#func _line_draw():
#	if len(self.scribble_points) < 2: return 
#	for i in self.scribble_points.size():
#		draw_line(self.scribble_points[i-1],self.scribble_points[i],self.color,self.width,self.anti_a)
#	for stroke in self.draw_stack:
#		if stroke.mouse_points.size() >2:
#			for i in stroke.mouse_points.size():
#				draw_line(stroke.mouse_points[i-1],stroke.mouse_points[i],self.color,self.width,self.anti_a)
		
