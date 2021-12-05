class_name HandwritingPen
extends Pen

enum DRAW_MODES {POLYLINE,POLYLINE_XFORM,TEXTURE,MULTILINE,LINE,CIRCLE,RECT}
var drawfuncs:Dictionary = {
	DRAW_MODES.POLYLINE: funcref(self,"_polyline_draw"),
	DRAW_MODES.POLYLINE_XFORM: funcref(self,"_xform_polyline_draw"),
	DRAW_MODES.LINE: funcref(self,"_line_draw"),
}

export var draw_mode = DRAW_MODES.POLYLINE_XFORM

onready var trail = $trail


func _draw():
	self.drawfuncs[self.draw_mode].call_func()
#	self.draw_set_transform_matrix(Transform2D.IDENTITY)
	self.draw_circle(get_global_mouse_position(),self.width,self.color)
#	self.draw_circle(self.data_xform.xform(get_global_mouse_position()),self.width,self.color)

func _input(event):
	if event.is_action_pressed("Increase_pen_size"):
		self.width += 0.1
		self.trail.width += 0.1
		print(self.width)
		print(self.trail.width)
	if event.is_action_pressed("decrease_pen_size"):
		self.width -= 0.1
		self.trail.width -= 0.1
		print(self.width)
		print(self.trail.width)
		

func scribble(_delta):
	if Input.is_action_just_pressed("draw"):
		self._clear_trail_points()
		self.bbox.size = Vector2.ZERO
		self.bbox.position = get_global_mouse_position()
	elif Input.is_action_pressed("draw"):
#		var pos:Vector2 = self._prev_mouse_pos.linear_interpolate(get_global_mouse_position(),0.1)
		var pos:Vector2 = get_global_mouse_position()
		self.stroke_data.append(pos)
		self._calc_bbox(pos)
		self.trail.add_point(pos)
	elif Input.is_action_just_released("draw"):
		Globals.draw_stack.push_back(Stroke.new(self))
		self.stroke_data.resize(0)
	else:
		self._remove_trail_point(0)
	self.update()
#	self._prev_mouse_pos = get_global_mouse_position()

func _calc_bbox(pos:Vector2):
	var min_x = min(pos.x,self.bbox.position.x)
	var min_y = min(pos.y,self.bbox.position.y)
	var max_x = max(pos.x,self.bbox.end.x)
	var max_y = max(pos.y,self.bbox.end.y)
	self.bbox.position=Vector2(min_x,min_y) #bottom left 
	self.bbox.size = Vector2(max_x-min_x,max_y-min_y) #top 

func _get_center(box:Rect2=self.bbox):
	return box.position+0.5*box.size

func _polyline_draw():
	if self.stroke_data.size() > 2:
		if self.width>1:draw_circle(self.stroke_data[0],self.width,self.color)
		self.draw_polyline(self.stroke_data,self.color,self.width,self.anti_a)
		if self.width>1:draw_circle(self.stroke_data[self.stroke_data.size()-1],self.width/2,self.color)
	for stroke in Globals.draw_stack:
		if stroke.mouse_points.size() >2:
			if stroke.width>1:self.draw_circle(stroke.mouse_points[0],stroke.width/2,stroke.color)
			self.draw_polyline(stroke.mouse_points,stroke.color,stroke.width,stroke.anti_a)
			if stroke.width>1:self.draw_circle(stroke.mouse_points[stroke.mouse_points.size()-1],stroke.width/2,stroke.color)

func _xform_polyline_draw():
	if self.stroke_data.size() > 2:
		self._set_draw_xform(self.bbox,self.width)
		self.draw_set_transform_matrix(self.draw_xform) #draw with the tranform
		self._set_data_xform(self.bbox,self.width)
		self.draw_circle(self.data_xform.xform(self.stroke_data[0]),self.width/2,self.color)
		self.draw_polyline(self.data_xform.xform(self.stroke_data),self.color,self.width,self.anti_a)
		self.draw_circle(self.data_xform.xform(self.stroke_data[-1]),self.width/2,self.color)
		self._debug_draw()
#	for stroke in Globals.draw_stack:
#		if stroke.mouse_points.size() >2:
#			self._set_draw_xform(stroke.bbox,stroke.width)
#			self.draw_set_transform_matrix(self.draw_xform) #draw with the tranform
#			self._set_data_xform(stroke.bbox,stroke.width)
#			self.draw_circle(self.data_xform.xform(stroke.mouse_points[0]),self.width/2,stroke.color)
#			self.draw_polyline(self.data_xform.xform(stroke.mouse_points),stroke.color,self.width,stroke.anti_a)
#			self.draw_circle(self.data_xform.xform(stroke.mouse_points[-1]),self.width/2,stroke.color)
##			self._debug_draw(stroke.bbox)

#SMOOTH but make app very laggy
func _line_draw():
	if len(self.stroke_data) < 2: return 
	for i in self.stroke_data.size():
		if i !=0:
			draw_line(self.stroke_data[i-1],self.stroke_data[i],self.color,self.width,self.anti_a)
			draw_circle(self.stroke_data[i],self.width/2,self.color)
#	for stroke in Globals.draw_stack:
#		if stroke.mouse_points.size() >2:
#			for i in stroke.mouse_points.size():
#				if i !=0:draw_line(stroke.mouse_points[i-1],stroke.mouse_points[i],self.color,self.width,self.anti_a)


func _set_draw_xform(box:Rect2,width:float):
		self.draw_xform.origin = self._get_center(box) #move transform point to center of bounding box
		self.draw_xform.x.x = width/self.width
		self.draw_xform.y.y = width/self.width


func _set_data_xform(box:Rect2,width:float):
		self.data_xform.origin = -self.width*self._get_center(box)/width#transform all drawing corrdinates abck to the origonal translation
		self.data_xform.x.x = self.width/width
		self.data_xform.y.y = self.width/width


func _debug_draw(box:Rect2=self.bbox):
	self.draw_rect(self.data_xform.xform(box),Color.chartreuse,false,1,true)
	self.draw_circle(self.data_xform.xform(box.end),2,Color.red)
	self.draw_circle(self.data_xform.xform(box.position),2,Color.yellow)
	self.draw_circle(self.data_xform.xform(self._get_center(box)),2,Color.blue)


func _clear_trail_points()->void:
	if self.trail.get_point_count() > 0:
		self.trail.clear_points()

func _remove_trail_point(mpos:int)->void:
	if self.trail.get_point_count() >0:
		self.trail.remove_point(mpos)
