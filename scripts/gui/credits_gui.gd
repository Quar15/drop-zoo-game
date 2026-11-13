class_name CreditsGUI
extends PanelContainer

signal exited

@export var back_btn: Button


func _ready() -> void:
	InputManager.back_pressed.connect(on_back_btn_pressed)


func show_up() -> void:
	self.visible = true
	self.mouse_filter = Control.MOUSE_FILTER_STOP

	if InputManager.is_controller():
		back_btn.grab_focus()


func on_back_btn_pressed() -> void:
	if not self.visible:
		return

	self.visible = false
	self.mouse_filter = Control.MOUSE_FILTER_IGNORE
	exited.emit()
