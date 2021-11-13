extends PopupPanel


## Called when the node enters the scene tree for the first time.
#func _ready():
#	self.offset = Vector2.ZERO

func _input(event):
	if event.is_action_pressed("ShowMenue"):
		self.show()

func show():
	self.rect_global_position=get_global_mouse_position()
	self.popup()
