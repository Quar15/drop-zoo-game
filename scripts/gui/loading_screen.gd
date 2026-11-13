class_name LoadingScreen
extends CanvasLayer

const TRANSITION_SHOW_ANIMATION_NAME: String = "transition_show"
const TRANSITION_HIDE_ANIMATION_NAME: String = "transition_hide"

@export var animation_player: AnimationPlayer


func animate_show() -> void:
	animation_player.play(TRANSITION_SHOW_ANIMATION_NAME)


func animate_hide() -> void:
	animation_player.play(TRANSITION_HIDE_ANIMATION_NAME)
