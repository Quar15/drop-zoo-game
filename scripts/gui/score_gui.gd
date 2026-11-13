class_name ScoreGUI
extends VBoxContainer

@export var score_increment_time: float = 2.0
@export var score_label: RichTextLabel
@export var high_score_label: RichTextLabel

@export var flying_points_prefab: PackedScene
@export var flying_points_parent: Control
var flying_points_pool: Array[FlyingPoints]
var starting_font_size: int

var text_tween: Tween = null

var score_displayed: int = 0


func setup(high_score: int) -> void:
	score_displayed = 0
	score_label.text = "0"
	high_score_label.text = "%d" % high_score
	starting_font_size = score_label.get_theme_font_size("normal_font_size")


func update_score(score: int, high_score: int) -> void:
	if text_tween and text_tween.is_valid():
		text_tween.kill()

	text_tween = create_tween()
	text_tween.set_parallel()
	text_tween.tween_property(self, "score_displayed", score, score_increment_time)
	text_tween.tween_method(
		func(_u: int) -> void: score_label.text = "%d" % score_displayed, 0, 0, score_increment_time
	)
	if score > high_score:
		text_tween.tween_method(
			func(_u: int) -> void: high_score_label.text = "%d" % score_displayed,
			0,
			0,
			score_increment_time
		)


func _instantiate_or_reuse_flying_point() -> FlyingPoints:
	for p: FlyingPoints in flying_points_pool:
		if not p.is_active:
			p.hide()
			return p

	var new_flying_points: FlyingPoints = flying_points_prefab.instantiate()
	new_flying_points.hide()
	flying_points_pool.append(new_flying_points)
	flying_points_parent.add_child(new_flying_points)
	return new_flying_points


func animate_flying_points(start_pos: Vector2, points: int) -> void:
	@warning_ignore("integer_division")
	var points_to_spawn: int = max((points / 10) / 5, 1)
	for p: int in range(points_to_spawn):
		var fp: FlyingPoints = _instantiate_or_reuse_flying_point()

		var points_gathered_sfx: Callable = func() -> void:
			AudioManager.create_audio(SoundEffect.Type.POINTS_UP)

		var end_pos: Vector2 = score_label.get_global_transform() * (score_label.size * 0.5)

		var tween: Tween = fp.animate(start_pos, end_pos, 0.5, p * 0.1)
		tween.tween_callback(points_gathered_sfx)
		tween.tween_property(
			score_label, "theme_override_font_sizes/normal_font_size", starting_font_size + 12, 0.1
		)
		tween.tween_property(
			score_label, "theme_override_font_sizes/normal_font_size", starting_font_size, 0.05
		)
