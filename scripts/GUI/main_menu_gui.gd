extends Control

const main_game_scene := preload("uid://384qb3wcvp3c")

@export var game_world_parent: Node
@export var main_menu_parent: Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass  # Replace with function body.


func on_play_btn_clicked() -> void:
	if not game_world_parent:
		printerr("Main Menu does not have reference to game world parent!")
		return
	if not main_menu_parent:
		printerr("Main Menu does not have reference to main menu parent!")
		return

	var game_scene_instance = main_game_scene.instantiate()
	game_world_parent.add_child(game_scene_instance)
	main_menu_parent.queue_free()


func on_options_btn_clicked() -> void:
	pass


func on_credits_btn_clicked() -> void:
	pass


func on_quit_btn_clicked() -> void:
	get_tree().quit()


func on_btn_hover() -> void:
	AudioManager.create_audio(SoundEffect.SOUND_EFFECT_TYPE.UI_HOVER)

func on_btn_click() -> void:
	AudioManager.create_audio(SoundEffect.SOUND_EFFECT_TYPE.UI_CLICK)
