#class_name Stroke
extends Node2D

var draw_xform:Transform2D = Transform2D.IDENTITY
var data_xform:Transform2D = Transform2D.IDENTITY
var stroke_data:PoolVector2Array
var bbox:Rect2 = Rect2(Vector2.ZERO,Vector2.ZERO)
var id:int

var width:float = 1.5
var color:Color = Color.black
var anti_a:bool = true
var texture:Texture


func _init(scrib:Pen):
	self.width = scrib.width
	self.color = scrib.color
	self.texture = scrib.texture
	self.anti_a = scrib.anti_a
#	self.stroke_data = self._process_points(scrib.scribble_points)
	self.stroke_data = scrib.stroke_data
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
	var min_x = stroke_data[0].x
	var max_x = stroke_data[0].x
	var min_y = stroke_data[0].y
	var max_y = stroke_data[0].y
	for p in self.stroke_data:
		min_x = min(p.x,min_x)
		max_x = max(p.x,max_x)
		min_y = min(p.y,min_y)
		max_y = max(p.y,max_y)
	var top_left = Vector2(min_x,min_y)
	var size = Vector2(max_x-min_x,max_y-min_y)
	return Rect2(top_left,size)
func _draw():
	for point in self.stroke_data:
		self.draw_set_transform_matrix(self.draw_xform)
		self.draw_circle(self.point_xform.xform(self.stroke_data[0]),self.draw_width/2,self.color)			
		self.draw_polyline(self.point_xform.xform(self.stroke_data),self.color,self.draw_width,self.anti_a)
		self.draw_circle(self.point_xform.xform(self.stroke_data[-1]),self.draw_width/2,self.color)			
		
		
		
