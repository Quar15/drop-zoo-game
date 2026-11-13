class_name PauseScreen
extends Control

@export var options_gui: OptionsGUI

@export var resume_btn: Button

@export var keyboard_hint: Control
@export var controller_hint: Control

var can_toggle: bool = true


func _ready() -> void:
	InputManager.device_changed.connect(change_hints)
	InputManager.back_pressed.connect(back)

	options_gui.exited.connect(on_options_exited)
	change_hints(InputManager.current_device)


func change_hints(device: InputManager.DeviceType) -> void:
	if device == InputManager.DeviceType.KEYBOARD_MOUSE:
		keyboard_hint.visible = true
		controller_hint.visible = false
		InputManager.unfocus()
	else:
		controller_hint.visible = true
		keyboard_hint.visible = false
		if self.visible:
			resume_btn.grab_focus()


func toggle() -> void:
	if not can_toggle:
		return

	if not self.visible:
		options_gui.back()
		if InputManager.is_controller():
			resume_btn.grab_focus()
	self.visible = not self.visible
	get_tree().paused = not get_tree().paused


func back() -> void:
	if not can_toggle:
		return

	if options_gui.visible:
		return

	self.visible = false
	get_tree().paused = false


func on_resume_btn_pressed() -> void:
	toggle()


func on_options_btn_pressed() -> void:
	options_gui.show_up()


func on_options_exited() -> void:
	if InputManager.is_controller():
		resume_btn.grab_focus()


func on_restart_btn_pressed() -> void:
	SceneManager.load_game()


func on_main_menu_btn_pressed() -> void:
	SceneManager.load_main_menu()
