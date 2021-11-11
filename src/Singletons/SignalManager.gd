extends Node

signal fps_changed(val)

func _ready():
	self.connect("fps_changed",self,"_on_fps_update")


func _on_fps_update(new_fps):
	Engine.target_fps=new_fps
