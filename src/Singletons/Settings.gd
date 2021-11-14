extends Node

enum SCRIBBLE_SETTINGS {WIDTH,COLOR,ANITIALIASING,TEXTURE,
			SHOW_TRAIL,TRAIL_WIDTH,TRAIL_COLOR,TRAIL_ANTIALIASING,TRAIL_TEXTURE}

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

