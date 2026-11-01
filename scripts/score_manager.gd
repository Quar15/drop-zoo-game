class_name ScoreManager
extends Node

signal score_changed(score: int, high_score: int)

var score: int = 0
var high_score: int = 0


func setup(n_high_score: int) -> void:
	score = 0
	high_score = n_high_score


func add_score(value: int) -> void:
	score += value

	if score > high_score:
		high_score = score

	score_changed.emit(score, high_score)
