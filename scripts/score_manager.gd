class_name ScoreManager
extends Node

signal score_changed(score: int, high_score: int)

var score: int = 0
var high_score: int = 0

var save_path = "user://highscore.save"


func setup() -> void:
	score = 0
	high_score = load_highscore()


func add_score(value: int) -> void:
	score += value

	if score > high_score:
		high_score = score

	score_changed.emit(score, high_score)


func save_highscore() -> void:
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	if file:
		file.store_64(high_score)
		file.close()


func load_highscore() -> int:
	if not FileAccess.file_exists(save_path):
		return 0

	var file = FileAccess.open(save_path, FileAccess.READ)
	if file == null:
		return 0

	var n_score = file.get_64()
	file.close()

	return n_score
