extends TextureRect

export var size = "A4"
export var page_color = Color.antiquewhite
var sizes ={
	"A4":Vector2(595,842)
}

export var draw_border:bool = true
export var border_width:int = 5
export var border_color:Color = Color.black

onready var page_rect = Rect2(Vector2.ZERO,self.sizes[self.size])
onready var border_rect = Rect2(Vector2(-1,-1)*self.border_width/2.0,
						page_rect.size+Vector2(1,1)*self.border_width)
onready var viewport = $Viewport
onready var grid = $Grid
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
	self.texture = tex
	self.viewport.size = self.page_rect.size
	$Grid.canvas_dim = self.page_rect.size
	$Grid.update()
	$Sprite.position= Vector2(border_rect.size.x,0)
#	self.save_page()
	

#func _input(event):
#	if event.is_action_pressed("save"):
#		self.save_page()
#
#func _process(_delta):
#	$Viewport.set_clear_mode(Viewport.CLEAR_MODE_ONLY_NEXT_FRAME)
##	self._update_children($Viewport)
#	yield(VisualServer,"frame_post_draw")
#	var img:Image = $Viewport.get_texture().get_data()
#	img.lock()
#	img.flip_y()
#	img.save_png("test.png")
#	var tex = ImageTexture.new()
#	tex.create_from_image(img)
#	self.texture = tex
#	$Viewport.set_clear_mode(Viewport.CLEAR_MODE_ALWAYS)


func _draw():
#	draw_rect(page_rect,Color.antiquewhite,true)
	if self.draw_border:
		draw_rect(self.border_rect,self.border_color,false,self.border_width)


#func save_page():
##	var tempz = $Viewport/Camera2D.zoom
##	var tempo = $Viewport/Camera2D.offset
##	$Viewport/Camera2D.zoom = Vector2(1,1)
##	$Viewport/Camera2D.offset = Vector2.ZERO
##	self._update_children($Viewport)
#	img.lock()
#	img.flip_y()
#	img.save_png("test.png")
#	var tex = ImageTexture.new()
#	tex.create_from_image(img)
#	$Sprite.texture = tex
##	$Viewport/Camera2D.zoom = tempz
##	$Viewport/Camera2D.offset = tempo

#	self.set_process(true)

func _update_children(parent:Node):
	for child in parent.get_children():
		if child is CanvasItem:
			child.update()
			self._update_children(child)

