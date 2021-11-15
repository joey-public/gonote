extends Node

enum SCRIBBLE_SETTINGS {WIDTH,COLOR,ANITIALIASING,TEXTURE,
			SHOW_TRAIL,TRAIL_WIDTH,TRAIL_COLOR,TRAIL_ANTIALIASING,TRAIL_TEXTURE}
enum CURSOR_SETTINGS {CURSOR_SIZE, CURSOR_SIZE_SMALL, SHOW_CURSOR_FILL, CURSOR_FILL_COLOR, CURSOR_FILL_ALPHA,
					   SHOW_CURSOR_BORD, CURSOR_BORD_COLOR, CURSOR_BORD_ALPHA, CURSOR_BORD_WIDTH}


var scribble_settings:Dictionary = {
	SCRIBBLE_SETTINGS.WIDTH:1.0,
	SCRIBBLE_SETTINGS.COLOR:Color.black,
	SCRIBBLE_SETTINGS.ANITIALIASING:true,
	SCRIBBLE_SETTINGS.TEXTURE:null,
	SCRIBBLE_SETTINGS.SHOW_TRAIL:true,
	SCRIBBLE_SETTINGS.TRAIL_WIDTH:3.0,
	SCRIBBLE_SETTINGS.TRAIL_COLOR:Color.yellow,
	SCRIBBLE_SETTINGS.TRAIL_ANTIALIASING:true,
	SCRIBBLE_SETTINGS.TRAIL_TEXTURE:null,
}

var cursor_settings:Dictionary = {
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
