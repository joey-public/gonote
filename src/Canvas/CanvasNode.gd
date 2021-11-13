class_name Canvas
extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$Camera2D.offset=$Page.size/2


func _input(event):
	if event.is_action_pressed("save"):
		self.save_page()


func save_page():
	$Camera2D.zoom = Vector2(1,1)
	$Camera2D.offset=Vector2.ZERO

	var viewport = self.get_viewport()
	viewport.set_clear_mode(Viewport.CLEAR_MODE_ONLY_NEXT_FRAME)
	yield(VisualServer,"frame_post_draw")
	var img:Image = viewport.get_texture().get_data()
	img.flip_y()
	img.crop($Page.size.x,$Page.size.y)
#	img.save_png("test.png")
	var tex = ImageTexture.new()
	tex.create_from_image(img)
	$Page/Sprite.texture = tex
	viewport.set_clear_mode(Viewport.CLEAR_MODE_ALWAYS)
