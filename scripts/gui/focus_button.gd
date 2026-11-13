class_name FocusButton
extends AnimatedButton

enum ClickAction { FOCUS, PRESS, TOGGLE }

@export var node_to_focus: Control
@export var action: ClickAction


func _ready() -> void:
	super._ready()
	self.pressed.connect(_on_pressed)


func _on_pressed() -> void:
	if action == ClickAction.FOCUS:
		node_to_focus.grab_focus()
	elif action == ClickAction.PRESS:
		node_to_focus.emit_signal("pressed")
	elif action == ClickAction.TOGGLE:
		node_to_focus.button_pressed = not node_to_focus.button_pressed
		node_to_focus.emit_signal("toggled", node_to_focus.button_pressed)
