class_name ContainerTween
extends Container

enum ORDER { START_TOP, START_BOTTOM }

@export var target: Container
@export var delay_appear: float = 0.2
@export var delay_between_elements: float = 0.05
@export var order_type: ORDER
@export var duration: float = 0.2

var tween: Tween


func _ready() -> void:
	if not target:
		target = self

	target.set_meta("container_tween", self)

	for c: Control in target.get_children():
		c.offset_transform_enabled = true
		c.offset_transform_scale = Vector2.ZERO
		c.modulate.a = 0.0
		c.offset_transform_pivot = c.size / 2.0


func animate() -> void:
	if tween and tween.is_running():
		tween.kill()
	tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	tween.set_parallel(true)

	if delay_appear > 0.0:
		tween.tween_interval(delay_appear)
		tween.chain().tween_interval(0.01)

	var children: Array[Node] = target.get_children()
	if order_type == ORDER.START_BOTTOM:
		children.reverse()

	var idx: int = 0
	for c: Control in children:
		c.offset_transform_scale = Vector2.ZERO
		c.modulate.a = 0.0
		(
			tween
			. tween_property(c, "offset_transform_scale", Vector2.ONE, duration)
			. from(Vector2.ZERO)
			. set_delay(delay_between_elements * idx)
		)
		tween.tween_property(c, "modulate:a", 1.0, 0.01).set_delay(delay_between_elements * idx)
		idx += 1


func animate_reverse() -> void:
	if tween and tween.is_running():
		tween.kill()
	tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	tween.set_parallel(true)

	if delay_appear > 0.0:
		tween.tween_interval(delay_appear)
		tween.chain().tween_interval(0.01)

	var children: Array[Node] = target.get_children()
	if order_type != ORDER.START_BOTTOM:
		children.reverse()

	var idx: int = 0
	for c: Control in children:
		c.offset_transform_scale = Vector2.ONE
		c.modulate.a = 1.0
		(
			tween
			. tween_property(c, "offset_transform_scale", Vector2.ZERO, duration)
			. from(Vector2.ONE)
			. set_delay(delay_between_elements * idx)
		)
		tween.tween_property(c, "modulate:a", 0.0, duration).set_delay(delay_between_elements * idx)
		idx += 1
