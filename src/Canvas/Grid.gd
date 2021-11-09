extends Node2D

export var selected_grid:String = "line"
export var grid_size:int = 32
export var fixed_canvans = false
export var canvas_dim:Vector2=Vector2.ZERO

export var grids:Dictionary = {
	"dot":funcref(self,"_draw_dot_grid"),
	"line":funcref(self,"_draw_grid"),
	"engineer":funcref(self,"_draw_eng_grid"),
	"dot_line":funcref(self,"_draw_dot_line_grid"),
	"hline":funcref(self,"_draw_dot_line_grid"),
	"vline":funcref(self,"_draw_dot_line_grid"),
}

export var dot_grid_settings:Dictionary = {
	"dot_size": 1.5,
	"dot_color": Color.gray,
	"dot_alpha":0.5,
}
export var line_grid_settings:Dictionary = {
	"line_width":1.0,
	"line_color":Color.gray,
	"line_alpha":0.5,
}
export var eng_grid_settings:Dictionary = {
	"inner_line_width":1.0,
	"inner_line_color":Color.gray,
	"inner_line_alpha":1.0,
	"outer_line_width":2.0,
	"outer_line_color":Color.darkgray,
	"outer_line_alpha":1.0,
}

var spacing:Vector2
var line_count:Vector2

func _ready():
	self._set_canvas_dim()
	self._set_line_count()
	self.spacing = self.grid_size*Vector2(1,1)


func _process(_delta):
	var temp = self.get_viewport().get_visible_rect().size
	if temp!=self.canvas_dim and !self.fixed_canvans:
		print("viewport changed")
		self._set_canvas_dim()
		self._set_line_count()
		self.update()


func _draw()->void:
	self.grids[self.selected_grid].call_func(self.line_count)
	print("done_drawing grid")


func _draw_dot_grid(size:Vector2)->void:
	var pos:Vector2 = self.spacing / 2
	var radius:float = self.dot_grid_settings["dot_size"]
	var color:Color = self.dot_grid_settings["dot_color"]
	color.a = self.dot_grid_settings["dot_alpha"]
	var x = 0
	var y = 0
	draw_circle(pos,radius,color)
	for r in size.y+2:
		for c in size.x+2:
			pos.x += self.spacing.x
			draw_circle(pos,radius,color)
			y=c
		pos.x = -self.spacing.x/2
		pos.y += self.spacing.y
		x=r
	print(x)
	print(y)
	print(x*y)
	print(size)

func _draw_grid(size:Vector2)->void:
	var lw:float = self.line_grid_settings["line_width"]
	var color:Color = self.line_grid_settings["line_color"]
	color.a = self.line_grid_settings["line_alpha"]
	var start:Vector2 = Vector2(0,self.spacing.y)
	var end:Vector2 = Vector2(self.canvas_dim.x,self.spacing.y)
	for r in size.y+1:
		draw_line(start,end,color,lw)
		start.y += self.spacing.y
		end.y += self.spacing.y
	start = Vector2(self.spacing.x,0)
	end = Vector2(self.spacing.x,self.canvas_dim.y)
	for c in size.x+1:
		draw_line(start,end,color,lw)
		start.x += self.spacing.x
		end.x += self.spacing.x
	print(size)


func _darw_eng_grid(size:Vector2)->void:
	pass


func _draw_dot_line_grid(size:Vector2)->void:
	self._draw_dot_grid(size)
	self._draw_grid(size)


func _draw_hline_grid(size:Vector2)->void:
	pass


func _draw_vline_grid(size:Vector2)->void:
	pass
	

func _set_canvas_dim():
	if self.fixed_canvans:
		return 
	else:
		self.canvas_dim = self.get_viewport().get_visible_rect().size


func _set_line_count():
	var gs = self.grid_size*Vector2(1,1)
	self.line_count = self._even_spacing_vec(gs,self.canvas_dim)

func _even_spacing_vec(s:Vector2,y:Vector2)->Vector2:
	var ans := Vector2.ZERO;
	ans.x = self._num_of_line(s.x,y.x)
	ans.y = self._num_of_line(s.y,y.y)
	return ans

func _num_of_line(s:int,y:int)->int:
	return int(ceil((y/s) - 1))
