class_name GameManager
extends Node

@export var score_manager: ScoreManager
@export var gui_manager: GUIManager

@export var animals: Array[Animal]
@export var animal_resources: Array[AnimalResource]
@export var player: Player

@export var death_area: DeathArea


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var high_score: int = 1000  # @TODO: Load highscore
	score_manager.setup(high_score)
	score_manager.score_changed.connect(gui_manager.handle_score_change)

	gui_manager.setup(high_score)
	player.next_animal_selected.connect(gui_manager.next_animal_gui.setup)

	for a in animals:
		a.animal_is_merging.connect(on_animal_merging)

	player.game_manager = self

	death_area.body_entered.connect(on_death_area_entered)


func on_animal_merging(a: Animal, b: Animal) -> void:
	if int(b.data.type) >= animal_resources.size() - 1:
		score_manager.add_score(b.data.score)
		printt("@DEBUG: Score added:", b.data.score, "and destroyed")
		a.queue_free()
		b.queue_free()
		return

	score_manager.add_score(b.data.score)
	printt("@DEBUG: Score added:", b.data.score)
	b.setup(animal_resources[int(b.data.type) + 1])
	b.hit_flash.play_hit_flash()
	a.queue_free()
	b.retrigger_check()
	death_area.retrigger_check()


func on_animal_touched_ground() -> void:
	death_area.retrigger_check()


func on_death_area_entered(body: Node2D) -> void:
	if not body is Animal:
		return

	if not body.touched_ground:
		return

	printt("@DEBUG:", body.name, body.data.name)
	end_game()


func end_game() -> void:
	get_tree().paused = true
	print("@INFO: finished game")
