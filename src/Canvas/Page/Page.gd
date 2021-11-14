extends Control

var Scribbles = preload("res://src/Canvas/Scribble/Scribbles.tscn")
var Grid = preload("res://src/Canvas/Grid/Grid.tscn")

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
onready var scribbles = $Sprite2/Scribbles
onready var Grid2 = $Sprite2/Grid2
func _ready():
#	$Viewport.size = self.page_rect.size
#	print($Viewport.size)
	self.size = self.sizes[self.size]
	self.rect_size = self.size
	var img = Image.new()
	img.create(page_rect.size.x,page_rect.size.y,false,Image.FORMAT_RGBA8)
	img.lock()
	img.fill(page_color)
	var tex := ImageTexture.new()
	tex.create_from_image(img)
	self.sprite.texture = tex
	get_parent()._center_page()
#	$Sprite2.connect("mouse_entered",$Sprite2/Scribbles,"_on_mouse_enter_page")
#	$Sprite2.connect("mouse_exited",$Sprite2/Scribbles,"_on_mouse_exit_page")


func _draw():
#	draw_rect(page_rect,Color.antiquewhite,true)
	if self.draw_border:
		draw_rect(self.border_rect,self.border_color,false,self.border_width)


func _update_children(parent:Node):
	for child in parent.get_children():
		if child is CanvasItem:
			print(child)
			child.update()
			self._update_children(child)

