class_name ScoreGUI
extends VBoxContainer

var score_displayed: int = 0

## Value change per second
@export var score_increment_time: float = 2.0
@export var score_label: RichTextLabel
@export var high_score_label: RichTextLabel

var tween: Tween = null


func setup(high_score: int) -> void:
	score_displayed = 0
	score_label.text = "0"
	high_score_label.text = "%d" % high_score


func update_score(score: int, high_score: int) -> void:
	if tween and is_instance_valid(tween):
		tween.kill()

	tween = create_tween()
	tween.set_parallel()
	tween.tween_property(self, "score_displayed", score, score_increment_time)
	tween.tween_method(func(_u): score_label.text = "%d" % score_displayed, 0, 0, score_increment_time)
	if score > high_score:
		tween.tween_method(func(_u): high_score_label.text = "%d" % score_displayed, 0, 0, score_increment_time)
