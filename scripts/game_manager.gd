class_name GameManager
extends Node

@export var score_manager: ScoreManager
@export var gui_manager: GUIManager


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var high_score: int = 1000  # @TODO: Load highscore
	score_manager.setup(high_score)
	score_manager.score_changed.connect(gui_manager.handle_score_change)

	gui_manager.setup(high_score)
