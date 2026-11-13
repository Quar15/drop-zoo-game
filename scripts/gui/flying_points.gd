class_name FlyingPoints
extends Control

var tween: Tween
var is_active: bool = false


func animate(start_pos: Vector2, end_pos: Vector2, duration: float, delay: float) -> Tween:
	is_active = true
	if tween and tween.is_valid():
		tween.kill()

	hide()
	self.position = start_pos

	var scatter_pos: Vector2 = (
		start_pos + Vector2(randf_range(-50.0, 50.0), randf_range(-50.0, 50.0))
	)
	var control_pos: Vector2 = (scatter_pos + end_pos) * 0.5 + Vector2(0.0, -80.0)

	var move_along_arc: Callable = func(t: float) -> void:
		var a: Vector2 = scatter_pos.lerp(control_pos, t)
		var b: Vector2 = control_pos.lerp(end_pos, t)
		self.position = a.lerp(b, t)

	tween = create_tween()
	tween.tween_interval(delay)
	tween.tween_callback(show)
	tween.tween_property(self, "position", scatter_pos, 0.1)
	tween.tween_method(move_along_arc, 0.0, 1.0, duration)
	tween.tween_callback(hide)
	tween.tween_property(self, "is_active", false, 0)

	return tween
