extends Line2D

var max_len = 100
onready var parent = get_parent()

func _ready():
	self.set_as_toplevel(true)

func _physics_process(_delta):
	if Input.is_action_pressed("draw"):
		self.add_point(get_global_mouse_position())
	else:
		if self.get_point_count() > 0:
			self.remove_point(0)
		

