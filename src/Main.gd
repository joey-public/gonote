extends Control



onready var canvas = $MarginContainer/VBoxContainer/WorkArea/HBoxContainer/MarginContainer2/Panel2/VBoxContainer/Panel/MarginContainer/ViewportContainer/Viewport/CanvasNode
onready var cursor = $MarginContainer/VBoxContainer/WorkArea/HBoxContainer/MarginContainer2/Panel2/VBoxContainer/Panel/MarginContainer/DrawViewport/Viewport/Cursor


func _on_DrawViewport_mouse_entered():
	self.cursor.set_cursor(true)


func _on_DrawViewport_mouse_exited():
	self.cursor.set_cursor(false)
