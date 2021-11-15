class_name Cursor
extends Sprite

#enum CURSOR_SETTINGS {SHOW_CURSOR_FILL, CURSOR_FILL_COLOR, CURSOR_FILL_ALPHA,
#					   SHOW_CURSOR_BORD, CURSOR_BORD_COLOR, CURSOR_BORD_ALPHA, CURSOR_BORDER_WIDTH}

const DEFAULT_CURSOR_SIZE = 10
const DEFAULT_CURSOR_SIZE_SMALL = 5

const DEFAULT_SHOW_CURSOR_FILL = true
const DEFAULT_CURSOR_FILL_COLOR = Color.aqua
const DEFAULT_CURSOR_FILL_ALPHA= 0.4

const DEFAULT_SHOW_CURSOR_BORD = true
const DEFAULT_CURSOR_BORD_COLOR = Color.darkslateblue
const DEFAULT_CURSOR_BORD_ALPHA = 0.8
const DEFAULT_CURSOR_BORD_WIDTH = 1.0

var radius 
var small_size
var large_size
var show_fill 
var fill_color 
var show_border
var border_color
var border_width

onready var tween = $Tween
func _ready():
	self._on_settings_updated()

func _input(event):
	if event.is_action_pressed("draw"):
		self.tween.stop_all()
		self.tween.interpolate_property(self,"radius",large_size,small_size,0.5,Tween.TRANS_EXPO,Tween.EASE_OUT)
		self.tween.start()
	if event.is_action_released("draw"):
		self.tween.stop_all()
		self.tween.interpolate_property(self,"radius",small_size,large_size,0.5,Tween.TRANS_EXPO,Tween.EASE_OUT)
		self.tween.start()

func _process(_delta):
	self.update()

func _draw():
	if self.show_border:
		self.draw_arc(get_global_mouse_position(),self.radius,0,2*PI,50,self.border_color,self.border_width,true)
	if self.show_fill:
		self.draw_circle(get_global_mouse_position(),self.radius,self.fill_color)

func _on_settings_updated():
	radius = Settings.cursor_settings[Settings.CURSOR_SETTINGS.CURSOR_SIZE]
	large_size = Settings.cursor_settings[Settings.CURSOR_SETTINGS.CURSOR_SIZE]
	small_size = Settings.cursor_settings[Settings.CURSOR_SETTINGS.CURSOR_SIZE_SMALL]
	show_fill = Settings.cursor_settings[Settings.CURSOR_SETTINGS.SHOW_CURSOR_FILL]
	fill_color = Settings.cursor_settings[Settings.CURSOR_SETTINGS.CURSOR_FILL_COLOR] * Settings.cursor_settings[Settings.CURSOR_SETTINGS.CURSOR_FILL_ALPHA]
	show_border = Settings.cursor_settings[Settings.CURSOR_SETTINGS.SHOW_CURSOR_BORD]
	border_color = Settings.cursor_settings[Settings.CURSOR_SETTINGS.CURSOR_BORD_COLOR] * Settings.cursor_settings[Settings.CURSOR_SETTINGS.CURSOR_BORD_ALPHA]
	border_width = Settings.cursor_settings[Settings.CURSOR_SETTINGS.CURSOR_BORD_WIDTH]
