class_name CreditsGUI
extends PanelContainer


func show_up() -> void:
	self.visible = true
	self.mouse_filter = Control.MOUSE_FILTER_STOP


func on_back_btn_pressed() -> void:
	self.visible = false
	self.mouse_filter = Control.MOUSE_FILTER_IGNORE


func on_btn_hover() -> void:
	AudioManager.create_audio(SoundEffect.SOUND_EFFECT_TYPE.UI_HOVER)


func on_btn_click() -> void:
	AudioManager.create_audio(SoundEffect.SOUND_EFFECT_TYPE.UI_CLICK)
