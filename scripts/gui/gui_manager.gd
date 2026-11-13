class_name GUIManager
extends Node

@export var score_gui: ScoreGUI
@export var next_animal_gui: NextAnimalGUI
@export var pause_screen: PauseScreen
@export var end_screen: EndScreenGUI

var _game_ended: bool = false


func _ready() -> void:
	InputManager.menu_pressed.connect(handle_menu_pressed)


func setup(high_score: int) -> void:
	score_gui.setup(high_score)
	_game_ended = false


func handle_score_change(score: int, high_score: int) -> void:
	score_gui.update_score(score, high_score)


func handle_menu_pressed() -> void:
	if _game_ended:
		return

	pause_screen.toggle()


func on_death() -> void:
	pause_screen.can_toggle = false
