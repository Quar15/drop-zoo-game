class_name EndScreenGUI
extends Control

@export var final_score_label: RichTextLabel
@export var highscore_label: RichTextLabel
@export var highscore_text_label: RichTextLabel
@export var biggest_merge_icon: TextureRect
@export var biggest_merge_label: RichTextLabel

@export var play_again_btn: Button


func _ready() -> void:
	InputManager.device_changed.connect(on_device_changed)


func setup(score: int, highscore: int, biggest_merge: AnimalResource) -> void:
	final_score_label.text = "[shake rate=5.0]%d[/shake]" % score
	highscore_label.text = "[shake rate=5.0]%d[/shake]" % highscore

	if score >= highscore:
		highscore_text_label.text = "[shake rate=5.0]NEW[/shake] Best"
	else:
		highscore_text_label.text = "Best"

	biggest_merge_icon.texture = biggest_merge.texture
	biggest_merge_label.text = biggest_merge.name.capitalize()

	self.visible = true
	if InputManager.is_controller():
		play_again_btn.grab_focus()


func on_play_again_btn_pressed() -> void:
	SceneManager.load_game()


func on_main_menu_btn_pressed() -> void:
	SceneManager.load_main_menu()


func on_btn_hover() -> void:
	AudioManager.create_audio(SoundEffect.Type.UI_HOVER)


func on_btn_click() -> void:
	AudioManager.create_audio(SoundEffect.Type.UI_CLICK)


func on_device_changed(_device: InputManager.DeviceType) -> void:
	if not self.visible:
		return

	if InputManager.is_controller():
		play_again_btn.grab_focus()
