extends Control

@export var keyboard_hints_parent: Control
@export var controller_hints_parent: Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	InputManager.device_changed.connect(change_hints)


func change_hints(device: InputManager.DeviceType) -> void:
	if device == InputManager.DeviceType.KEYBOARD_MOUSE:
		keyboard_hints_parent.visible = true
		controller_hints_parent.visible = false
	else:
		controller_hints_parent.visible = true
		keyboard_hints_parent.visible = false
