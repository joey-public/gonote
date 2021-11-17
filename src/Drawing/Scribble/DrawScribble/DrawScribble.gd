class_name DrawScribble
extends Scribbles

enum DRAW_MODES {POLYLINE,POLYLINE_XFORM,TEXTURE,MULTILINE,LINE,CIRCLE,RECT}
var drawfuncs:Dictionary = {
	DRAW_MODES.POLYLINE: funcref(self,"_polyline_draw"),
	DRAW_MODES.POLYLINE_XFORM: funcref(self,"_xform_polyline_draw"),
	DRAW_MODES.TEXTURE: funcref(self,"_texture_draw"),
	DRAW_MODES.MULTILINE: funcref(self,"_multiline_draw"),
	DRAW_MODES.LINE: funcref(self,"_line_draw"),
	DRAW_MODES.CIRCLE: funcref(self,"_circle_draw"),
	DRAW_MODES.RECT: funcref(self,"_rect_draw"),
}
var draw_mode = DRAW_MODES.POLYLINE_XFORM
var xform:Transform2D

var _pen = null
var _prev_mouse_pos = Vector2()
#var _use_moving_average:bool = true

func _ready():
#	self.width = 10.0
	var img = Image.new()
	img.load("res://NoteTaking.png")
	img.resize(self.width*2,self.width*2)
	self.texture = ImageTexture.new()
	self.texture.create_from_image(img)
	self.xform.origin = Vector2.ZERO
	self.xform.x = self.width*Vector2(1,0)
	self.xform.y = self.width*Vector2(0,1)

func _draw():
	self.drawfuncs[self.draw_mode].call_func()

func _input(event):
	if event.is_action_pressed("Increase_pen_size"):
		self.width += 0.1
		print(self.width)
	if event.is_action_pressed("decrease_pen_size"):
		self.width -= 0.1
		print(self.width)

func scribble(_delta):
	if Input.is_action_just_pressed("draw"):
		self._clear_trail_points()
		self.bbox.size = Vector2.ZERO
		self.bbox.position = get_global_mouse_position()
	elif Input.is_action_pressed("draw"):
#		var pos:Vector2 = self._prev_mouse_pos.linear_interpolate(get_global_mouse_position(),0.1)
		var pos:Vector2 = get_global_mouse_position()
		self.scribble_points.append(pos)
		self._calc_bbox(pos)
		self.trail.add_point(pos)
		self.update()
	elif Input.is_action_just_released("draw"):
		self.draw_stack.push_back(Scribbles.Stroke.new(self))
		self.scribble_points.resize(0)
	else:
		self._remove_trail_point(0)
	self._prev_mouse_pos = get_global_mouse_position()

func _calc_bbox(pos:Vector2):
	var min_x = min(pos.x,self.bbox.position.x)
	var min_y = min(pos.y,self.bbox.position.y)
	var max_x = max(pos.x,self.bbox.end.x)
	var max_y = max(pos.y,self.bbox.end.y)
	self.bbox.position=Vector2(min_x,min_y) #bottom left 
	self.bbox.size = Vector2(max_x-min_x,max_y-min_y) #top 

func _get_center():
	return self.bbox.position+0.5*self.bbox.size

func _polyline_draw():
	if self.scribble_points.size() > 2:
		if self.width>1:draw_circle(self.scribble_points[0],self.width,self.color)
		self.draw_polyline(self.scribble_points,self.color,self.width,self.anti_a)
#		self.draw_rect(self.bbox,Color.chartreuse,false,self.width,true)
		if self.width>1:draw_circle(self.scribble_points[self.scribble_points.size()-1],self.width/2,self.color)
	for stroke in self.draw_stack:
		if stroke.mouse_points.size() >2:
#			self.draw_rect(stroke.bbox,Color.blueviolet,false,1,true)
			if stroke.width>1:self.draw_circle(stroke.mouse_points[0],stroke.width/2,stroke.color)
			self.draw_polyline(stroke.mouse_points,stroke.color,stroke.width,stroke.anti_a)
			if stroke.width>1:self.draw_circle(stroke.mouse_points[stroke.mouse_points.size()-1],stroke.width/2,stroke.color)

func _xform_polyline_draw():
	if self.scribble_points.size() > 3:
		self.xform.origin = self._get_center() #move transform point to center of bounding box
		self.xform.x.x = self.width
		self.xform.y.y = self.width
		self.draw_set_transform_matrix(self.xform) #draw with the tranform
		self.xform.origin = -self.width*self._get_center() #transform all drawing corrdinates abck to the origonal translation
		if self.width>1:draw_circle(self.xform.xform(self.scribble_points[0]),self.width,self.color)
		self.draw_polyline(self.xform.xform(self.scribble_points),self.color,1,self.anti_a)
		self.draw_rect(self.xform.xform(self.bbox),Color.chartreuse,false,1,true)
		self.draw_circle(self.xform.xform(self.bbox.end),2,Color.red)
		self.draw_circle(self.xform.xform(self.bbox.position),2,Color.yellow)
		self.draw_circle(self.xform.xform(self._get_center()),2,Color.blue)
		if self.width>1:draw_circle(self.xform.xform(self.scribble_points[self.scribble_points.size()-1]),self.width/2,self.color)
#	for stroke in self.draw_stack:
#		if stroke.mouse_points.size() >2:
#			self.draw_rect(stroke.bbox,Color.blueviolet,false,1,true)
#			if stroke.width>1:self.draw_circle(stroke.mouse_points[0],stroke.width/2,stroke.color)
#			self.draw_polyline(stroke.mouse_points,stroke.color,stroke.width,stroke.anti_a)
#			if stroke.width>1:self.draw_circle(stroke.mouse_points[stroke.mouse_points.size()-1],stroke.width/2,stroke.color)


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

#SMOOTH but make app very laggy
func _line_draw():
	if len(self.scribble_points) < 2: return 
	for i in self.scribble_points.size():
		if i !=0:
			draw_line(self.scribble_points[i-1],self.scribble_points[i],self.color,self.width,self.anti_a)
			draw_circle(self.scribble_points[i],self.width/2,self.color)
#	for stroke in self.draw_stack:
#		if stroke.mouse_points.size() >2:
#			for i in stroke.mouse_points.size():
#				if i !=0:draw_line(stroke.mouse_points[i-1],stroke.mouse_points[i],self.color,self.width,self.anti_a)

func _rect_draw():
	if self.scribble_points.size()<1: return 
	if self.scribble_points.size()==1: 
#		draw_circle(self.scribble_points[0],self.width,self.color)
		return
	self.draw_circle(get_global_mouse_position(),self.width/2,self.color)
	for i in self.scribble_points.size():
		if i != 0 : 
			var p1 = self.scribble_points[i-1] #last mouse pos
			var p2 = self.scribble_points[i] #current mouse pos
			var v:Vector2 = p2-p1
			var rot = v.angle() - PI/2
			var scale = Vector2(1,1)
			var pos = -self.width/2*Vector2(1,1)
			var size = Vector2(self.width,v.length())
			var r = Rect2(pos,size)
			self.draw_set_transform(p1,rot,Vector2(1,1))
			self.draw_rect(r,self.color,true,1.0,false)
			self.draw_circle(Vector2.ZERO,self.width/2,self.color)
#			self.draw_circle(v,self.width/2,self.color)
#			self.draw_set_transform(Vector2.ZERO,0.0,Vector2(1,1))
#	var p1 = self.scribble_points[0] #last mouse pos
#	var p2 = get_global_mouse_position() #current mouse pos
#	var v:Vector2 = p2-p1
#	var rot = v.angle() - PI/2
#	var scale = Vector2(1,1)
#	var pos = p1-self.width/2*Vector2(1,1)
#	var size = Vector2(self.width,v.length())
#	var r = Rect2(Vector2.ZERO,size)
#	var t:Transform2D = Transform2D()
#	t.origin = p1
#	t.x.x = cos(rot)
#	t.y.y = cos(rot)
#	t.x.y = sin(rot)
#	t.y.x = -sin(rot)
#	draw_circle(self.scribble_points[0],self.width*5,self.color)
#	draw_circle(get_global_mouse_position(),self.width*5,self.color)
##	draw_set_transform_matrix(t)
#	draw_set_transform(p1,rot,scale)
#	draw_rect(r,self.color)

		
		

