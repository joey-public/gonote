class_name Canvas
extends Node2D
var prev_offset = Vector2.ZERO

var redraw_from:int 
var redraw_to:int
# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.connect("redraw_stack",self,"_on_redraw_stack")
#	self._center_page()


func _input(event):
	if event.is_action_pressed("save"):
		self.save_page()
	if event.is_action_pressed("fit"):
		self._center_page()


func save_page():
	$Camera2D.zoom = Vector2(1,1)
	$Camera2D.offset=Vector2.ZERO
	var viewport = self.get_viewport()
	viewport.set_clear_mode(Viewport.CLEAR_MODE_ONLY_NEXT_FRAME)
	yield(VisualServer,"frame_post_draw")
	var img:Image = viewport.get_texture().get_data()
	img.flip_y()
	img.crop($Page.size.x,$Page.size.y)
	img.decompress()
	img.lock()
#	var tex = ImageTexture.new()
#	tex.create_from_image(img)
#	$Page/Sprite.texture = tex
	viewport.set_clear_mode(Viewport.CLEAR_MODE_ALWAYS)
#	img.save_png("test.png")


func _center_page():
	var pg_rec:Rect2 = $Page.page_rect
#	print(pg_rec)
	var vp_rec:Rect2 = self.get_viewport_rect()
#	print(vp_rec)
	var ofst:Vector2 = -0.5*(vp_rec.size-pg_rec.size)
	if $Camera2D.offset != ofst:
		$Camera2D/offset_tween.interpolate_property($Camera2D,"offset",$Camera2D.offset,ofst, 0.5,
												Tween.TRANS_EXPO,Tween.EASE_IN)
		$Camera2D/offset_tween.start()
	if $Camera2D.zoom != Vector2(1,1):
		$Camera2D/zoom_tween.interpolate_property($Camera2D,"zoom",$Camera2D.zoom,Vector2(1,1), 0.5,
												Tween.TRANS_EXPO,Tween.EASE_IN)
		$Camera2D/zoom_tween.start()
#	$Camera2D.zoom = Vector2(1,1)
#	$Camera2D.offset = ofst

	
func _on_redraw_stack(from:int=0,to:int=-1):
	print("redrawing_stack")
	if to ==-1: to = Globals.draw_stack.size()
	self.redraw_from = from
	self.redraw_to = to
	self.update()


func _draw():
	for i in range(self.redraw_from,self.redraw_to):
#		Globals.draw_stack[i].draw(self)
		self.draw_circle(Globals.draw_stack[i].bbox.end,10,Color.black)
		
