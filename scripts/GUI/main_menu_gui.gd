extends Control

@export var options_gui: OptionsGUI
@export var credits_gui: CreditsGUI

@export var play_btn: Button


func _ready() -> void:
	InputManager.device_changed.connect(on_device_changed)
	options_gui.exited.connect(on_options_exited)
	credits_gui.exited.connect(on_credits_exited)
	refocus()


func refocus() -> void:
	if InputManager.is_controller():
		play_btn.grab_focus()


func on_play_btn_clicked() -> void:
	SceneManager.load_game()


func on_options_btn_clicked() -> void:
	options_gui.show_up()


func on_options_exited() -> void:
	refocus()


func on_credits_btn_clicked() -> void:
	credits_gui.show_up()


func on_credits_exited() -> void:
	refocus()


func on_quit_btn_clicked() -> void:
	get_tree().quit()


func on_btn_hover() -> void:
	AudioManager.create_audio(SoundEffect.SOUND_EFFECT_TYPE.UI_HOVER)


func on_btn_click() -> void:
	AudioManager.create_audio(SoundEffect.SOUND_EFFECT_TYPE.UI_CLICK)


func on_device_changed(_device: InputManager.DeviceType) -> void:
	if not InputManager.is_controller():
		InputManager.unfocus()
		return

	if options_gui.visible or credits_gui.visible:
		return

	play_btn.grab_focus()
