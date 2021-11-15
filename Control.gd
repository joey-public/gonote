# Via https://godotengine.org/qa/24621/painting-game-persist-drawing
# Based on http://zylannprods.fr/dl/godot/godot3/ChalkBoard.zip
extends Control

var _pen = null
var _prev_mouse_pos = Vector2()
var size = 1.0

func _ready():
	var viewport = Viewport.new()
	var rect = get_rect()
	viewport.size = rect.size
	viewport.usage = Viewport.USAGE_2D
	# Note: I also tried CLEAR_MODE_NEVER but it doesn't draw anything.
	# (see issue https://github.com/godotengine/godot/issues/20775)
	viewport.render_target_clear_mode = Viewport.CLEAR_MODE_ONLY_NEXT_FRAME
	viewport.render_target_v_flip = true

	_pen = Node2D.new()
	viewport.add_child(_pen)
	_pen.connect("draw", self, "_on_draw")

	add_child(viewport)

	# Use a sprite to display the result texture
	var rt = viewport.get_texture()
	var board = TextureRect.new()
	board.set_texture(rt)
	add_child(board)


func _process(delta):
	_pen.update()


func _input(event):
	if event.is_action_pressed("Increase_pen_size"):
		self.size += 0.1
		print(self.size)
	if event.is_action_pressed("decrease_pen_size"):
		self.size -= 0.1
		print(self.size)


func _on_draw():
	var mouse_pos = get_local_mouse_position()

	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		_pen.draw_line(mouse_pos, _prev_mouse_pos, Color(1, 1, 0),self.size)
#		_pen.draw_line(mouse_pos, _prev_mouse_pos, Color(1, 1, 0),10.0)

	_prev_mouse_pos = mouse_pos
	_prev_mouse_pos = mouse_pos
	
