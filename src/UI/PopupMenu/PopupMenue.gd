extends Control

export var start_scale:Vector2 = Vector2(0.5,0.5)
export var end_scale:Vector2 = Vector2(2,2)

onready var tween = $Tween

func _ready():
	self.visible = false
	self.rect_scale = self.start_scale

func _input(event):
	if event.is_action_pressed("ShowMenue"):
		if self.visible == false:
			self.rect_position = self.get_global_mouse_position() + Vector2(-55,-60)
			self.visible = true
			self._tween_in()
		else:
			self._tween_out()
			self.rect_scale = self.start_scale
			yield(self.tween,"tween_completed")
			self.visible = false


func _tween_in():
	self.tween.interpolate_property(self,"rect_scale",self.start_scale,self.end_scale,0.5,Tween.TRANS_EXPO,Tween.EASE_OUT)
	self.tween.start()
func _tween_out():
	self.tween.interpolate_property(self,"rect_scale",self.end_scale,self.start_scale,0.5,Tween.TRANS_EXPO,Tween.EASE_OUT)
	self.tween.start()
