class_name AnimatedButton
extends Button

var tween: Tween

const WIDTH_FULL_ROT: float = 256.0


func _ready() -> void:
	self.pressed.connect(_on_button_click)
	self.focus_entered.connect(_on_button_focus)
	self.mouse_entered.connect(_on_button_hover)

	self.focus_exited.connect(_on_button_unfocus)
	self.mouse_exited.connect(_on_button_unhovered)


func animate_hover() -> void:
	if disabled:
		return

	pivot_offset = size / 2.0

	var scale_ratio: float = clampf(WIDTH_FULL_ROT / size.x, 0.5, 1.0)
	var scale_target: float = 1.0 + (0.2) * scale_ratio

	if tween and tween.is_running():
		tween.kill()
	tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	tween.tween_property(self, "scale:x", scale_target, 0.2)
	tween.parallel().tween_property(self, "scale:y", scale_target, 0.35)
	tween.parallel().tween_property(
		self, "rotation_degrees", 5.0 * scale_ratio * [-1.0, 1.0].pick_random(), 0.1
	)
	tween.parallel().tween_property(self, "rotation_degrees", 0.0, 0.1).set_delay(0.1)

	AudioManager.create_audio(SoundEffect.Type.UI_HOVER)


func animate_unhover() -> void:
	if disabled:
		return

	pivot_offset = size / 2.0

	var scale_target: float = 1.0

	if tween and tween.is_running():
		tween.kill()
	tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	tween.tween_property(self, "scale:x", scale_target, 0.2)
	tween.parallel().tween_property(self, "scale:y", scale_target, 0.35)
	tween.parallel().tween_property(self, "rotation_degrees", 0.0, 0.1).set_delay(0.1)


func _on_button_hover() -> void:
	animate_hover()


func _on_button_unhovered() -> void:
	animate_unhover()


func _on_button_focus() -> void:
	if InputManager.is_controller():
		animate_hover()


func _on_button_unfocus() -> void:
	if InputManager.is_controller():
		animate_unhover()


func _on_button_click() -> void:
	AudioManager.create_audio(SoundEffect.Type.UI_CLICK)
