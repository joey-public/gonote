extends Node

signal change_scribble_settings
signal change_cursor_settings
signal change_cursor_mode

signal scribble_settings_changed
signal cursor_settings_changed
signal cursor_mode_changed

enum SCRIBBLE_SETTINGS {WIDTH,COLOR,ANITIALIASING,TEXTURE,
			SHOW_TRAIL,TRAIL_WIDTH,TRAIL_COLOR,TRAIL_ANTIALIASING,TRAIL_TEXTURE}
enum CURSOR_SETTINGS {CURSOR_MODE, CURSOR_SIZE, CURSOR_SIZE_SMALL, SHOW_CURSOR_FILL, CURSOR_FILL_COLOR, CURSOR_FILL_ALPHA,
					   SHOW_CURSOR_BORD, CURSOR_BORD_COLOR, CURSOR_BORD_ALPHA, CURSOR_BORD_WIDTH}


var scribble_settings:Dictionary = {
	SCRIBBLE_SETTINGS.WIDTH:Scribbles.DEFAULT_WIDTH,
	SCRIBBLE_SETTINGS.COLOR:Scribbles.DEFAULT_COLOR,
	SCRIBBLE_SETTINGS.ANITIALIASING:Scribbles.DEFAULT_ANTI_A,
	SCRIBBLE_SETTINGS.TEXTURE:Scribbles.DEFAULT_TEXTURE,
	SCRIBBLE_SETTINGS.SHOW_TRAIL:Scribbles.DEFAULT_SHOW_TRAIL,
	SCRIBBLE_SETTINGS.TRAIL_WIDTH:Scribbles.DEFAULT_TRAIL_WIDTH,
	SCRIBBLE_SETTINGS.TRAIL_COLOR:Scribbles.DEFAULT_TRAIL_COLOR,
	SCRIBBLE_SETTINGS.TRAIL_ANTIALIASING:Scribbles.DEFAULT_TRAIL_ANTI_A,
	SCRIBBLE_SETTINGS.TRAIL_TEXTURE:Scribbles.DEFAULT_TRAIL_TEXTURE,
}

var cursor_settings:Dictionary = {
	CURSOR_SETTINGS.CURSOR_MODE: Cursor.DEFAULT_CURSOR_MODE,
	CURSOR_SETTINGS.CURSOR_SIZE: Cursor.DEFAULT_CURSOR_SIZE,
	CURSOR_SETTINGS.CURSOR_SIZE_SMALL: Cursor.DEFAULT_CURSOR_SIZE_SMALL,
	CURSOR_SETTINGS.SHOW_CURSOR_FILL: Cursor.DEFAULT_SHOW_CURSOR_FILL,
	CURSOR_SETTINGS.CURSOR_FILL_COLOR:Cursor.DEFAULT_CURSOR_FILL_COLOR,
	CURSOR_SETTINGS.CURSOR_FILL_ALPHA:Cursor.DEFAULT_CURSOR_FILL_ALPHA,
	CURSOR_SETTINGS.SHOW_CURSOR_BORD:Cursor.DEFAULT_SHOW_CURSOR_BORD,
	CURSOR_SETTINGS.CURSOR_BORD_COLOR:Cursor.DEFAULT_CURSOR_BORD_COLOR,
	CURSOR_SETTINGS.CURSOR_BORD_ALPHA:Cursor.DEFAULT_CURSOR_BORD_ALPHA,
	CURSOR_SETTINGS.CURSOR_BORD_WIDTH:Cursor.DEFAULT_CURSOR_BORD_WIDTH,
}


func _ready():
	self.connect("change_scribble_settings",self,"_on_change_scribble_settings")
	self.connect("change_cursor_settings",self,"_on_change_cursor_settings")
	self.connect("change_cursor_mode",self,"_on_change_cursor_mode")




func _on_change_scribble_settings(new:Dictionary):
	for key in new:
		self.scribble_settings[key] = new[key]
	emit_signal("scribble_settings_chaged")


func _on_change_cursor_settings(new:Dictionary):
	for key in new:
		self.cursor_settings[key] = new[key] 
	emit_signal("change_cursor_settings")


func _on_change_cursor_mode(new:int):
	self.cursor_settings[CURSOR_SETTINGS.CURSOR_MODE] = new
	emit_signal("cursor_mode_changed")
