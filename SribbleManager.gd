extends Node2D


func _process(delta):
	if self.visible: 
#		if Input.is_action_just_pressed("draw"):
#			self._clear_trail_points()
		if Input.is_action_pressed("draw"):
#			if not(self._can_draw()): return 
#			SignalManager.emit_signal("fps_changed",
#									   Globals.refresh_rates["draw_rate"])
#			self.scribble_points.append(get_global_mouse_position())
			self.add_point(get_global_mouse_position())
#			self.trail.add_point(get_global_mouse_position())
#			self.update()
#			self.drawing_time += delta
		elif Input.is_action_just_released("draw"):
			print("draw done")
			SignalManager.emit_signal("fps_changed",
									   Globals.refresh_rates["slow_rate"])
			self.draw_stack.push_back(PoolVector2Array(self.scribble_points))
#			self._save_to_png(self.scribble_points)
			self.scribble_points.clear()
		else:
			self._remove_trail_point(0)
