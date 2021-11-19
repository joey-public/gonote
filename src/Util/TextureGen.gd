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
	
	self.emit_signal("done_drawing")

func _draw_plus():
	var r = self.get_viewport_rect()
	self.draw_circle(Vector2.ZERO,100,Color.black)
func _on_done_drawing():
	print("done_drawing")
	
