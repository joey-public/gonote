class_name Scribbles
extends Node2D

const DEFAULT_WIDTH:float = 1.0
const DEFAULT_COLOR:Color = Color.black
const DEFAULT_ANTI_A:bool = true
const DEFAULT_TEXTURE:Texture = null

const DEFAULT_SHOW_TRAIL:bool = true
const DEFAULT_TRAIL_WIDTH:float = 20.0
const DEFAULT_TRAIL_COLOR:Color = Color.black
const DEFAULT_TRAIL_ANTI_A:bool = true
const DEFAULT_TRAIL_TEXTURE:Texture = null

#declare instance variables
var width:float 
var color:Color 
var anti_a:bool 
var texture:Texture 

var show_trail:bool 
var trail_width:float 
var trail_color:Color 
var trail_anit_a:bool 
var trail_texture:Texture

var current_scribble = true
var scribble_points:PoolVector2Array = []
var undo_stack:Array = []
var draw_stack:Array = []


onready var trail = $Trail
onready var tween = $Tween
onready var sprite = $TextureSprite
onready var bbox:Rect2 = Rect2()


func _ready():
	self._on_settings_updated()

func _input(event):
	if not self.current_scribble: return 
	if event.is_action_pressed("undo"):
		if self.draw_stack.size()>0:
			self.undo_stack.push_back(self.draw_stack.pop_back())
			self.update()
	if event.is_action_pressed("redo"):
		if self.undo_stack.size()>0:
			self.draw_stack.push_back(self.undo_stack.pop_back())
			self.update()


func _process(delta):
	if not(self.current_scribble):return 
	self.update()
	self.scribble(delta)

#func _draw():
#	self.draw_circle(get_global_mouse_position(),self.width/2,self.color)

func scribble(delta):
	pass


func _clear_trail_points()->void:
	if self.trail.get_point_count() > 0:
		self.trail.clear_points()

func _remove_trail_point(mpos:int)->void:
	if self.trail.get_point_count() >0:
		self.trail.remove_point(mpos)

func _on_settings_updated()->void:
	self.width = Settings.scribble_settings[Settings.SCRIBBLE_SETTINGS.WIDTH]
	self.color = Settings.scribble_settings[Settings.SCRIBBLE_SETTINGS.COLOR]
	self.anti_a = Settings.scribble_settings[Settings.SCRIBBLE_SETTINGS.ANITIALIASING]
	self.texture = Settings.scribble_settings[Settings.SCRIBBLE_SETTINGS.TEXTURE]

	self.show_trail = Settings.scribble_settings[Settings.SCRIBBLE_SETTINGS.SHOW_TRAIL]
	self.trail_width = Settings.scribble_settings[Settings.SCRIBBLE_SETTINGS.TRAIL_WIDTH]
	self.trail_color = Settings.scribble_settings[Settings.SCRIBBLE_SETTINGS.TRAIL_COLOR]
	self.trail_anit_a = Settings.scribble_settings[Settings.SCRIBBLE_SETTINGS.TRAIL_ANTIALIASING]
	self.trail_texture = Settings.scribble_settings[Settings.SCRIBBLE_SETTINGS.TRAIL_TEXTURE]


class Stroke:
	extends Resource
	var width:float
	var color:Color
	var texture:Texture
	var anti_a:bool
	var mouse_points:PoolVector2Array
	var bbox:Rect2
	func _init(scrib:Scribbles):
		self.width = scrib.width
		self.color = scrib.color
		self.texture = scrib.texture
		self.anti_a = scrib.anti_a
		self.mouse_points = self._process_points(scrib.scribble_points)
		self.bbox = scrib.bbox
	func map_mouse_pos_to_px():
		pass
	func _process_points(p:PoolVector2Array)->PoolVector2Array:
		return self._moving_average(p,10)
	func _moving_average(p:PoolVector2Array,N:int)->PoolVector2Array:
		return p
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
	
