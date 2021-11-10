extends Node2D

const Scribble = preload("res://src/Draw/Scribble.tscn")

export var cursor_settings:Dictionary ={
	"type":"circle",
	"size":50.0,
	"fill_color":Color.yellowgreen,
	"fill_alpha":0.3,
	"border_color":Color.yellowgreen,
	"border_width":3,
	"border_alpha":0.5,
	"draw_border":true,
	"dot_size":2,
	"dot_color":Color.black,
	"dot_alpha":0.5,
	"draw_dot":true,
}
var cursor = "circle"
var scribble = NAN
var scribble_points:PoolVector2Array
var canvas = NAN
var cursors:Dictionary = {
	"circle":funcref(self,"_draw_circle_cursor")
}

onready var pos = self.get_global_mouse_position()
onready var sampler = $Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	self.scribble = Scribble.instance()
	self.canvas = self.get_parent().get_node("CanvasNode")
	self.canvas.add_child(self.scribble)

func _input(event):
	if event.is_action_pressed("draw"):
		self.sampler.start()
	if event.is_action_released("draw"):
		self.sampler.stop()
		self.scribble = Scribble.instance()
		self.canvas.add_child(self.scribble)
		
		

func _process(_delta):
	if self.visible: 
		self.position = self.get_global_mouse_position()
		self.update()
#		if Input.is_action_pressed("draw"):
#			self.scribble.add_point(self.position)
#		elif Input.is_action_just_released("draw"):
#			print(self.pos)
#			print(self.position)
#			print(self.get_global_mouse_position())
#			print(self.get_local_mouse_position())
#			self.scribble = Scribble.instance()
#			self.canvas.add_child(self.scribble)
			
			


func _draw():
	self.cursors[cursor].call_func()
#	draw_circle(Vector2.ZERO,50,Color.black)


func _draw_circle_cursor():
	var size = self.cursor_settings["size"]
	var color = self.cursor_settings["fill_color"]
	var draw_pos = self.pos + Vector2(12,30)#no idea why this makes the cirlse follow the mouse
	color.a = self.cursor_settings["fill_alpha"]
	draw_circle(draw_pos,size,color)
	if self.cursor_settings["draw_border"]:
		var border_width = self.cursor_settings["border_width"]
		color = self.cursor_settings["border_color"]
		color.a = self.cursor_settings["border_alpha"]
		draw_arc(draw_pos,size,0,2*PI,20,color,border_width)
	if self.cursor_settings["draw_dot"]:
		size = self.cursor_settings["dot_size"]
		color = self.cursor_settings["dot_color"]
		color.a = self.cursor_settings["dot_alpha"]
		draw_circle(draw_pos,size,color)


func set_cursor(special:bool):
	if special:
		self.visible = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		self.visible = false
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _on_Timer_timeout():
	self.scribble.add_point(self.position)
