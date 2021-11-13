extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var page = $CenterContainer/Page3

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _input(event):
	if event.is_action_pressed("save"):
		self.save()


func save():
	self.page.viewport.add_child($Scribbles.duplicate())
	self.page.viewport.add_child(self.page.grid.duplicate())
	self.page.viewport.get_node("Scribbles").update()
	self.page.viewport.set_clear_mode(Viewport.CLEAR_MODE_ONLY_NEXT_FRAME)
	yield(VisualServer,"frame_post_draw")
	var img:Image = self.page.viewport.get_texture().get_data()
#	img.lock()
	img.flip_y()
#	img.save_png("test.png")
	var tex = ImageTexture.new()
	tex.create_from_image(img)
	$Sprite.texture = tex
	self.page.viewport.set_clear_mode(Viewport.CLEAR_MODE_ALWAYS)
	
