extends Camera2D

export var max_zoom:Vector2 = Vector2(0.01,0.01)
export var min_zoom:Vector2= Vector2(10.0,10.0)
export var scroll_speed: int = 5
export var zoom_speed:float = 0.01

var _pan_start:Vector2
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(_event):
	pass
#	if event.is_action_pressed("zoom_in"):
#		self.zoom -= self.zoom/10
##		if self.zoom.x <= self.min_zoom.x: self.zoom = self.min_zoom
##		else: self.zoom -= self.zoom/10
#	elif event.is_action_pressed("zoom_out"):
#		self.zoom +=self.zoom/10
##		if self.zoom.x >= self.max_zoom.x: self.zoom = self.max_zoom
##		else: self.zoom += self.zoom/10
#	else:
#		pass


func _process(_delta):
	if Input.is_action_pressed("zoom_in"):
		self.zoom -= self.zoom*self.zoom_speed
	elif Input.is_action_pressed("zoom_out"):
		self.zoom +=self.zoom*self.zoom_speed
	elif Input.is_action_pressed("pan_left"):
		self.offset.x -= self.scroll_speed
	elif Input.is_action_pressed("pan_right"):
		self.offset.x += self.scroll_speed
	elif Input.is_action_pressed("pan_up"):
		self.offset.y -= self.scroll_speed
	elif Input.is_action_pressed("pan_down"):
		self.offset.y += self.scroll_speed
	elif Input.is_action_just_pressed("pan"):
		self._pan_start = self.get_global_mouse_position()
	elif Input.is_action_pressed("pan"):
		var new = self.get_global_mouse_position()
		offset -= (new-self._pan_start)/1
		
		
