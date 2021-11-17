extends Sprite


export var defaults_size = Vector2(500,500)

var save_path = "res://assets/GeneratedTextures/"
var save_name = "plus.png"
var pen:CanvasItem #pen can be set to any Canvas Item under the viewport

#onready var default_target:Sprite = self
onready var default_pen:Node2D = $CaptureViewport/Pen #by default use this to draw
onready var capture_viewport = $CaptureViewport

signal done_drawing

func _ready():
	self.connect("done_drawing",self,"_on_done_drawing")
	self.capture_viewport.usage = Viewport.USAGE_2D
	self.capture_viewport.render_target_update_mode = Viewport.UPDATE_ALWAYS
	self.capture_viewport.set_clear_mode(Viewport.CLEAR_MODE_ONLY_NEXT_FRAME)
	self.capture_viewport.size = self.defaults_size
	self.capture_viewport.render_target_v_flip = true
	self.capture_viewport.transparent_bg = true
	self.pen = self.default_pen
	self.pen.connect("draw",self,"_on_pen_draw")
	self.pen.update()
	self._capture()


func _move_to():
	pass


func _capture():
	yield(self,"done_drawing")
	print("capturing")
	yield(VisualServer,"frame_post_draw")
	var img:Image = self.capture_viewport.get_texture().get_data()
#	img.flip_y()
	img.lock()
	var tex = ImageTexture.new()
	tex.create_from_image(img)
	self.texture = tex
	print("done captureing")
#	img.save_png(self.save_path+save_name)

func _on_pen_draw():
	var button_col = Color.antiquewhite
#	button_col.a = 0.7
	var rect:Rect2 = Rect2(Vector2(0,0),Vector2(100,100))
	self.pen.draw_set_transform(Vector2.ZERO,45,Vector2(1,1))
	self.pen.draw_rect(rect,button_col,true)
	self.pen.draw_rect(rect,Color.black,false,2)
#	self.pen.draw_circle(Vector2.ZERO,10,button_col)
#	self.pen.draw_arc(Vector2.ZERO,10,0,2*PI,60,Color.black,2,true)
#	self.pen.draw_line(Vector2(-5,0),Vector2(5,0),Color.black,1.5)
#	self.pen.draw_line(Vector2(0,-5),Vector2(0,5),Color.black,1.5)
#	self.pen.draw_line(Vector2(0,0),Vector2(0,70),Color.black,1)
#	self.pen.draw_circle(Vector2(0,0),2,Color.black)#	self.pen.draw_circle(Vector2.ZERO,200,Color.antiquewhite)
#	var rect:Rect2 = Rect2(Vector2(-50,-75),Vector2(self.defaults_size.x,self.defaults_size.y))
#	self.pen.draw_rect(rect,Color.black,false,5.0)
#	var font = DynamicFont.new()
#	font.font_data = load("res://assets/IBMPlexMono-ThinItalic.ttf")
#	font.size = 8
#	self.pen.draw_char(font,Vector2.ZERO,"P","L")
#	self.pen.draw_circle(Vector2.ZERO,20,Color.white)
#	self.pen.draw_arc(Vector2(0,0),20,0,2*PI,30,Color.black,true)
#	self.pen.draw_circle(Vector2(250,250),10,Color.black)
	self.emit_signal("done_drawing")


func _on_done_drawing():
	print("done_drawing")
	
