class_name Stroke
extends Resource
var width:float
var color:Color
var texture:Texture
var anti_a:bool
var mouse_points:PoolVector2Array
var bbox:Rect2
var draw_xform:Transform2D = Transform2D.IDENTITY
var data_xform:Transform2D = Transform2D.IDENTITY
var draw_width:float
func _init(scrib:Pen):
	self.width = scrib.width
	self.color = scrib.color
	self.texture = scrib.texture
	self.anti_a = scrib.anti_a
#	self.mouse_points = self._process_points(scrib.scribble_points)
	self.mouse_points = scrib.stroke_data
	self.bbox = scrib.bbox
	self.draw_xform = scrib.draw_xform
	self.data_xform = scrib.data_xform
	self.draw_width = scrib.width
func map_mouse_pos_to_px():
	pass
#func _process_points(p:PoolVector2Array)->PoolVector2Array:
#	return self._moving_average(p,10)
#func _moving_average(p:PoolVector2Array,N:int)->PoolVector2Array:
#	return p
func _calc_bbox()->Rect2:
	var min_x = mouse_points[0].x
	var max_x = mouse_points[0].x
	var min_y = mouse_points[0].y
	var max_y = mouse_points[0].y
	for p in self.mouse_points:
		min_x = min(p.x,min_x)
		max_x = max(p.x,max_x)
		min_y = min(p.y,min_y)
		max_y = max(p.y,max_y)
	var top_left = Vector2(min_x,min_y)
	var size = Vector2(max_x-min_x,max_y-min_y)
	return Rect2(top_left,size)
func draw(canvas:CanvasItem):
	for point in self.mouse_points:
		canvas.draw_set_transform_matrix(self.draw_xform)
		canvas.draw_circle(self.point_xform.xform(self.mouse_points[0]),self.draw_width/2,self.color)			
		canvas.draw_polyline(self.point_xform.xform(self.mouse_points),self.color,self.draw_width,self.anti_a)
		canvas.draw_circle(self.point_xform.xform(self.mouse_points[-1]),self.draw_width/2,self.color)			
		
		
		

