class_name LoadingScreen
extends CanvasLayer

@export var animation_player: AnimationPlayer

const TRANSITION_SHOW_ANIMATION_NAME = "transition_show"
const TRANSITION_HIDE_ANIMATION_NAME = "transition_hide"


func animate_show() -> void:
	animation_player.play(TRANSITION_SHOW_ANIMATION_NAME)

func animate_hide() -> void:
	animation_player.play(TRANSITION_HIDE_ANIMATION_NAME)

