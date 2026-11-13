class_name GameManager
extends Node

signal game_ended

@export var score_manager: ScoreManager
@export var gui_manager: GUIManager

@export var animals: Array[Animal]
@export var animal_resources: Array[AnimalResource]
@export var player: Player

@export var death_area: DeathArea
var best_merge: AnimalResource = preload("uid://2hxr67giinsj")


func _ready() -> void:
	for i: int in range(0, animal_resources.size() - 2):
		assert(int(animal_resources[i + 1].type) > int(animal_resources[i].type))

	score_manager.setup()
	score_manager.score_changed.connect(gui_manager.handle_score_change)

	gui_manager.setup(score_manager.high_score)
	self.game_ended.connect(gui_manager.on_death)
	player.next_animal_selected.connect(gui_manager.next_animal_gui.setup)

	for a: Animal in animals:
		a.touched_animal.connect(_on_animal_touched)
		a.touched_ground.connect(_on_animal_touched_ground)

	player.new_animal_spawned.connect(_on_new_animal_spawned)

	death_area.body_entered.connect(_on_death_area_entered)
	get_tree().paused = false


func _on_new_animal_spawned(animal: Animal) -> void:
	animal.touched_animal.connect(_on_animal_touched)
	animal.touched_ground.connect(_on_animal_touched_ground)


func _animate_animal_merge(animal: Animal) -> void:
	gui_manager.score_gui.animate_flying_points(animal.global_position, animal.data.score)
	if int(animal.data.type) > int(best_merge.type):
		best_merge = animal.data


func _on_animal_touched(a: Animal, b: Animal) -> void:
	if int(b.data.type) >= animal_resources.size() - 1:
		score_manager.add_score(b.data.score)
		if OS.is_debug_build():
			printt("@DEBUG: Score added:", b.data.score, "and destroyed")

		_animate_animal_merge(b)
		a.queue_free()
		b.queue_free()
		return

	score_manager.add_score(b.data.score)
	if OS.is_debug_build():
		printt("@DEBUG: Score added:", b.data.score)

	b.setup(animal_resources[int(b.data.type) + 1])
	_animate_animal_merge(b)
	b.hit_flash.play_hit_flash()

	a.queue_free()
	b.retrigger_check()
	death_area.retrigger_check()


func _on_animal_touched_ground() -> void:
	death_area.retrigger_check()


func _on_death_area_entered(body: Node2D) -> void:
	if not body is Animal:
		return

	if not body.has_touched_ground:
		return

	if OS.is_debug_build():
		printt("@DEBUG:", body.name, body.data.name)
	end_game()


func end_game() -> void:
	get_tree().paused = true
	player.is_alive = false
	score_manager.save_highscore()
	gui_manager.end_screen.setup(score_manager.score, score_manager.high_score, best_merge)
	self.game_ended.emit()

	if OS.is_debug_build():
		print("@INFO: finished game")
