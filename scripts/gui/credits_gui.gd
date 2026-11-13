class_name CreditsGUI
extends PanelContainer

signal exited

@export var back_btn: Button
@export var control_tween: ControlTween


func _ready() -> void:
	InputManager.back_pressed.connect(on_back_btn_pressed)


func show_up() -> void:
	self.visible = true
	self.mouse_filter = Control.MOUSE_FILTER_STOP

	if InputManager.is_controller():
		back_btn.grab_focus()

	control_tween.animate()


func on_back_btn_pressed() -> void:
	if not self.visible:
		return

	var exit: Callable = func() -> void:
		self.visible = false
		self.mouse_filter = Control.MOUSE_FILTER_IGNORE
		exited.emit()

	control_tween.animate_reverse().finished.connect(exit)
