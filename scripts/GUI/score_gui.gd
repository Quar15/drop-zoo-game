class_name ScoreGUI
extends VBoxContainer

var score_displayed: int = 0

## Value change per second
@export var score_increment_speed: int = 25
@export var score_label: RichTextLabel
@export var high_score_label: RichTextLabel

var tween: Tween = null


func setup(high_score: int) -> void:
	score_displayed = 0
	score_label.text = "0"
	high_score_label.text = "%d" % high_score


func update_score(score: int, high_score: int) -> void:
	@warning_ignore("integer_division")
	var tween_duration: int = (score - score_displayed) / score_increment_speed

	if tween and is_instance_valid(tween):
		tween.kill()

	tween = create_tween()
	tween.set_parallel()
	tween.tween_property(self, "score_displayed", score, tween_duration)
	tween.tween_method(func(_u): score_label.text = "%d" % score_displayed, 0, 0, tween_duration)
	if score > high_score:
		tween.tween_method(
			func(_u): high_score_label.text = "%d" % score_displayed, 0, 0, tween_duration
		)
