extends Node2D

export var size = "A4"
export var page_color = Color.antiquewhite
var sizes ={
	"A4":Vector2(595,842)
}

export var draw_border:bool = true
export var border_width:int = 5
export var border_color:Color = Color.black

onready var sprite = $Sprite2
onready var page_rect = Rect2(Vector2.ZERO,self.sizes[self.size])
onready var border_rect = Rect2(Vector2(-1,-1)*self.border_width/2.0,
						page_rect.size+Vector2(1,1)*self.border_width)
# Called when the node enters the scene tree for the first time.
func _ready():
#	$Viewport.size = self.page_rect.size
#	print($Viewport.size)
	self.size = self.sizes[self.size]
	var img = Image.new()
	img.create(page_rect.size.x,page_rect.size.y,false,Image.FORMAT_RGBA8)
	img.lock()
	img.fill(page_color)
	var tex := ImageTexture.new()
	tex.create_from_image(img)
	self.sprite.texture = tex
	

func _input(event):
	if event.is_action_pressed("save"):
		self.save_page()


func _draw():
#	draw_rect(page_rect,Color.antiquewhite,true)
	if self.draw_border:
		draw_rect(self.border_rect,self.border_color,false,self.border_width)


func save_page():
#	self.set_process(false)
	var save_viewport := Viewport.new()
	save_viewport.name = "SaveViewport"
	save_viewport.size = self.page_rect.size
	save_viewport.own_world = true
#	save_viewport.transparent_bg = true
	save_viewport.usage = Viewport.USAGE_2D
	self.add_child(save_viewport)
	$SaveViewport.add_child(self.sprite.duplicate())
	print($SaveViewport.get_children())
	$SaveViewport.set_clear_mode(Viewport.CLEAR_MODE_ONLY_NEXT_FRAME)
	self._update_children($SaveViewport)
	yield(VisualServer,"frame_post_draw")
	var img:Image = $SaveViewport.get_texture().get_data()
	img.flip_y()
#	img.save_png("test.png")
	var tex = ImageTexture.new()
	tex.create_from_image(img)
	$Sprite.texture = tex
#	self.set_process(true)

func _update_children(parent:Node):
	for child in parent.get_children():
		if child is CanvasItem:
			child.update()
			self._update_children(child)
