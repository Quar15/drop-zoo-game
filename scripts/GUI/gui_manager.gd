class_name GUIManager
extends Node

@export var score_gui: ScoreGUI
@export var next_animal_gui: NextAnimalGUI
@export var pause_screen: PauseScreen


func _ready() -> void:
	InputManager.menu_pressed.connect(handle_menu_pressed)


func setup(high_score: int) -> void:
	score_gui.setup(high_score)


func handle_score_change(score: int, high_score: int) -> void:
	score_gui.update_score(score, high_score)


func handle_menu_pressed() -> void:
	pause_screen.toggle()
