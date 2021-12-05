extends DrawScribble


var _moving_avg_points:int = 50
var _filter:Array
var _signal:Array

func _ready():
	._ready()
	self._generate_filter()

func _draw():
	self.drawfuncs[self.draw_mode].call_func()


func scribble(_delta):
	if Input.is_action_just_pressed("draw"):
		self._clear_trail_points()
	elif Input.is_action_pressed("draw"):
		var mouse_pos = get_global_mouse_position()
		if self._moving_avg_points > 1 and self.scribble_points.size() > self._moving_avg_points:
			self.scribble_points.append(self._moving_average_filter(mouse_pos))
		else:
			self.scribble_points.append(mouse_pos)
#		var pos:Vector2 = self._prev_mouse_pos.linear_interpolate(get_global_mouse_position(),0.1)
#		self.scribble_points.append(pos)
		self.trail.add_point(get_global_mouse_position())
		self.update()
	elif Input.is_action_just_released("draw"):
		self.draw_stack.push_back(Scribbles.Stroke.new(self))
		self.scribble_points.clear()
	else:
		self._remove_trail_point(0)


func _moving_average_filter(xin:Vector2)->Vector2:
	self._signal.pop_front()
	self._signal.push_front(xin)
	var yout:Vector2 = Vector2(self._signal[0].x*self._filter[0].x,self._signal[0].y*self._filter[0].y)
	for m in range(2,self._moving_avg_points-1):
		m = int(m)
		yout = yout + Vector2(self._filter[m].x*self._signal[m].x,self._filter[m].y*self._signal[m].y)
		self._signal[m] = self._signal[m-1]
	return yout

func _generate_filter():
	for i in self._moving_avg_points:
		self._filter.append(Vector2(1,1))
		self._signal.append(Vector2.ZERO)
	print(self._filter)
	print(self._signal)
