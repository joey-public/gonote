extends Camera2D

const sixty_fps:float = 1/60.0;

export var max_zoom = 0.05
export var min_zoom = 3
export var scroll_speed:float = 150.0
export var zoom_speed:float = 200

var _pan_limits:Vector2
var _pan_start:Vector2
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

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


func _process(delta):
	if Input.is_action_just_pressed("pan"):
		self._pan_start = self.get_global_mouse_position()
		SignalManager.emit_signal("fps_changed",
									Globals.refresh_rates["pan_rate"])
	elif Input.is_action_pressed("pan"):
		var new = self.get_global_mouse_position()
		offset = offset - (new-self._pan_start)
	else:
		SignalManager.emit_signal("fps_changed",
									Globals.refresh_rates["slow_rate"])
	if Input.is_action_pressed("zoom_in") and self._can_zoom_in():
		self.zoom -= self.zoom*((self.zoom_speed*delta)/100)
	elif Input.is_action_pressed("zoom_out") and self._can_zoom_out():
		self.zoom += self.zoom*((self.zoom_speed*delta)/100)
	elif Input.is_action_pressed("pan_left"):
		self.offset.x -= self.scroll_speed*delta
	elif Input.is_action_pressed("pan_right"):
		self.offset.x += self.scroll_speed*delta
	elif Input.is_action_pressed("pan_up"):
		self.offset.y -= self.scroll_speed*delta
	elif Input.is_action_pressed("pan_down") and not Input.is_action_pressed("save"):
		self.offset.y += self.scroll_speed*delta


func _can_zoom_in()->bool:
	if self.zoom.x > self.max_zoom:
		return true
#	self.zoom = self.max_zoom*Vector2(1.0,1.0)
	return false
	

func _can_zoom_out()->bool:
	if self.zoom.x < self.min_zoom: return true
	return false
