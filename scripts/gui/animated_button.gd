class_name AnimatedButton
extends Button


func _ready() -> void:
	self.pressed.connect(on_button_click)
	self.focus_entered.connect(on_button_focus)
	self.mouse_entered.connect(on_button_hover)


func on_button_hover() -> void:
	AudioManager.create_audio(SoundEffect.Type.UI_HOVER)


func on_button_focus() -> void:
	if InputManager.is_controller():
		AudioManager.create_audio(SoundEffect.Type.UI_HOVER)


func on_button_click() -> void:
	AudioManager.create_audio(SoundEffect.Type.UI_CLICK)
