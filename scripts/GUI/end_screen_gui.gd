class_name EndScreenGUI
extends Control

@export var final_score_label: RichTextLabel
@export var highscore_label: RichTextLabel
@export var highscore_text_label: RichTextLabel
@export var biggest_merge_icon: TextureRect
@export var biggest_merge_label: RichTextLabel


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


func on_play_again_btn_pressed() -> void:
	SceneManager.load_game()


func on_main_menu_btn_pressed() -> void:
	SceneManager.load_main_menu()


func on_btn_hover() -> void:
	AudioManager.create_audio(SoundEffect.SOUND_EFFECT_TYPE.UI_HOVER)


func on_btn_click() -> void:
	AudioManager.create_audio(SoundEffect.SOUND_EFFECT_TYPE.UI_CLICK)
