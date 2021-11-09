extends Line2D

var max_len = 100
onready var parent = get_parent()

func _ready():
	self.set_as_toplevel(true)

#func _physics_process(_delta):
#	self.add_point(get_global_mouse_position())
#	if self.get_point_count() > max_len:
#		self.remove_point(0)

