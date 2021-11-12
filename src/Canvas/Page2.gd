extends TextureRect

export var size = "A4"
var sizes ={
	"A4":Vector2(595,842)
}

onready var page_rect = Rect2(Vector2.ZERO,self.sizes[self.size])
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _draw():
	draw_rect(page_rect,Color.antiquewhite,true)
	draw_rect(page_rect,Color.black,false,5)
