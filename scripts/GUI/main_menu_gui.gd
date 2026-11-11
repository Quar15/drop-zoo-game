extends Control

@export var options_gui: OptionsGUI


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass  # Replace with function body.


func on_play_btn_clicked() -> void:
	SceneManager.load_game()


func on_options_btn_clicked() -> void:
	options_gui.show_up()


func on_credits_btn_clicked() -> void:
	pass


func on_quit_btn_clicked() -> void:
	get_tree().quit()


func on_btn_hover() -> void:
	AudioManager.create_audio(SoundEffect.SOUND_EFFECT_TYPE.UI_HOVER)


func on_btn_click() -> void:
	AudioManager.create_audio(SoundEffect.SOUND_EFFECT_TYPE.UI_CLICK)
