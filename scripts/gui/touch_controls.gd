class_name TouchControls
extends Control

@export var left_btn: Button
@export var right_btn: Button
@export var drop_btn: Button

@export var touch_hints: Array[Control]

var hints_hidden: bool = false


func _ready() -> void:
	if OS.has_feature("web_android") or OS.has_feature("web_ios"):
		self.visible = true
		self.mouse_filter = Control.MOUSE_FILTER_STOP

		left_btn.button_down.connect(_on_left_button_down)
		left_btn.button_up.connect(_on_left_button_up)

		right_btn.button_down.connect(_on_right_button_down)
		right_btn.button_up.connect(_on_right_button_up)

		drop_btn.pressed.connect(_on_drop_btn_pressed)
	else:
		self.visible = false
		self.mouse_filter = Control.MOUSE_FILTER_IGNORE


func hide_hints() -> void:
	if hints_hidden:
		return
	hints_hidden = true
	for c: Control in touch_hints:
		c.hide()


func _on_left_button_down() -> void:
	hide_hints()
	InputManager.move_direction = -1.0


func _on_left_button_up() -> void:
	InputManager.move_direction = 0.0


func _on_right_button_down() -> void:
	hide_hints()
	InputManager.move_direction = 1.0


func _on_right_button_up() -> void:
	InputManager.move_direction = 0.0


func _on_drop_btn_pressed() -> void:
	hide_hints()
	InputManager.action_pressed.emit()
