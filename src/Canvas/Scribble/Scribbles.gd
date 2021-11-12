extends Node2D

export var color:Color = Color.black
export var width:float = 1
export var anti_a:bool = true

export var trail_off_speed:int = 50#ponts per sec

var scribble_points:Array = []
var draw_stack:Array = []
var drawing_time:float=0

onready var pos = self.get_global_mouse_position()
onready var trail = $Line2D
onready var tween = $Tween


func _process(delta):
	if self.visible: 
		if Input.is_action_just_pressed("draw"):
			self._clear_trail_points()
		elif Input.is_action_pressed("draw"):
			SignalManager.emit_signal("fps_changed",
									   Globals.refresh_rates["draw_rate"])
			self.scribble_points.append(get_global_mouse_position())
			self.trail.add_point(get_global_mouse_position())
			self.update()
			self.drawing_time += delta
		elif Input.is_action_just_released("draw"):
			SignalManager.emit_signal("fps_changed",
									   Globals.refresh_rates["slow_rate"])
			self.draw_stack.push_back(PoolVector2Array(self.scribble_points))
			self.scribble_points.clear()
		else:
			self._remove_trail_point(0)
#			var time = self.trail.get_point_count() / self.trail_off_speed;
#			self.tween.interpolate_method(self,"_remove_trail_point",0,0,
#										time+1,Tween.TRANS_EXPO,Tween.EASE_IN)
#			self.tween.start()

#interpolate_method
func _draw():
	if self.scribble_points.size() > 2:
		self.draw_polyline(self.scribble_points,self.color,self.width,self.anti_a)
	for scribble in self.draw_stack:
		if scribble.size() >2:
			self.draw_polyline(scribble,self.color,self.width,self.anti_a)

func _clear_trail_points()->void:
	if self.trail.get_point_count() > 0:
		self.trail.clear_points()

func _remove_trail_point(mpos:int)->void:
	if self.trail.get_point_count() >0:
		self.trail.remove_point(mpos)
##TODO
#to reduce draw calls remove items from the draw stack and instead 
#add to a StreamTexture object
func _batch_lines_to_texture():
	pass
