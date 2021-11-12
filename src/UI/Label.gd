extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
#func _input(event):
#	self.text = str(event)
#	self.text += ": "+str(event.get_device())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if delta !=0:
		self.text = "FPS: "+str(round(1/delta))
