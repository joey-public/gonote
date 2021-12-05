extends TextureButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	self.connect("mouse_entered",self,"_on_mouse_entered")
	self.connect("mouse_exited",self,"_on_mouse_exited")
	self.connect("pressed",self,"_on_pressed")

func _on_mouse_entered():
	self.show_behind_parent = false
func _on_mouse_exited():
	self.show_behind_parent = true
func _on_pressed():
	pass
