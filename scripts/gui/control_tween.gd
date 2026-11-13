class_name ControlTween
extends Node

enum DIRECTION { FROM_TOP, FROM_BOTTOM }

@export var target: Container
@export var delay_appear: float = 0.2
@export var direction: DIRECTION
@export var duration: float = 0.2
@export var exit_duration: float = 0.1

var tween: Tween


func _ready() -> void:
	if not target:
		target = get_parent()

	target.set_meta("container_tween", self)
	target.offset_transform_enabled = true
	target.modulate.a = 0.0
	target.offset_transform_pivot = target.size / 2.0


func get_from_position_ratio() -> Vector2:
	match direction:
		DIRECTION.FROM_TOP:
			return Vector2(0, -1.1)
		DIRECTION.FROM_BOTTOM:
			return Vector2(0, 1.1)
	return Vector2.ONE


func animate() -> Tween:
	if tween and tween.is_running():
		tween.kill()
	tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	tween.set_parallel(true)

	var from_position_ratio: Vector2 = get_from_position_ratio()
	target.offset_transform_position_ratio = from_position_ratio

	(
		tween
		. tween_property(target, "offset_transform_position_ratio", Vector2.ZERO, duration)
		. from(from_position_ratio)
		. set_delay(delay_appear)
	)
	tween.tween_property(target, "modulate:a", 1.0, 0.01)
	return tween


func animate_reverse() -> Tween:
	if tween and tween.is_running():
		tween.kill()
	tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	tween.set_parallel(true)

	var from_position_ratio: Vector2 = get_from_position_ratio()
	target.offset_transform_position_ratio = Vector2.ZERO

	(
		tween
		. tween_property(
			target, "offset_transform_position_ratio", from_position_ratio, exit_duration
		)
		. from(Vector2.ZERO)
	)
	tween.tween_property(target, "modulate:a", 0.0, exit_duration)
	return tween
