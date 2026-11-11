class_name PauseScreen
extends Control

@export var options_gui: OptionsGUI

@export var keyboard_hint: Control
@export var controller_hint: Control


func _ready() -> void:
	InputManager.device_changed.connect(change_hints)


func change_hints(device: InputManager.DeviceType) -> void:
	if device == InputManager.DeviceType.KEYBOARD_MOUSE:
		keyboard_hint.visible = true
		controller_hint.visible = false
	else:
		controller_hint.visible = true
		keyboard_hint.visible = false


func toggle() -> void:
	if not self.visible:
		options_gui.back()
	self.visible = !self.visible
	get_tree().paused = !get_tree().paused


func on_resume_btn_pressed() -> void:
	toggle()


func on_options_btn_pressed() -> void:
	options_gui.show_up()


func on_restart_btn_pressed() -> void:
	SceneManager.load_game()


func on_main_menu_btn_pressed() -> void:
	SceneManager.load_main_menu()


func on_btn_hover() -> void:
	AudioManager.create_audio(SoundEffect.SOUND_EFFECT_TYPE.UI_HOVER)


func on_btn_click() -> void:
	AudioManager.create_audio(SoundEffect.SOUND_EFFECT_TYPE.UI_CLICK)
