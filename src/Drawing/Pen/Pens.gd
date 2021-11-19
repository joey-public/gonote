extends Node2D


var prev_pen = NAN

onready var draw_pen = $DrawScribble
onready var erase_pen = $EraserScribble

onready var cur_pen = $DrawScribble

func _ready():
	self.cur_pen.is_active = true
	
	
func _input(event):
	if event.is_action_pressed("Erase"):
		Settings.emit_signal("change_cursor_mode",Cursor.CURSOR_MODES.RECTANGE)
		self._change_pen(self.erase_pen)

func _change_pen(new_pen:Scribbles):
	self.cur_pen.is_active = false
	self.prev_pen = self.cur_pen
	self.cur_pen = new_pen
	self.cur_pen.is_active = true
