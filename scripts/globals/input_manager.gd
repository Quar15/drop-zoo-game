extends Node

signal action_pressed
signal menu_pressed
signal back_pressed

signal device_changed(device: DeviceType)
enum DeviceType { KEYBOARD_MOUSE, GENERIC_PAD, XBOX, PLAYSTATION, NINTENDO, STEAM }

const GAME_ACTIONS: Array[String] = [
	"left", "right", "action", "menu", "ui_left", "ui_right", "ui_up", "ui_down"
]

var move_direction: float = 0.0
var current_device: DeviceType = DeviceType.KEYBOARD_MOUSE


func _ready() -> void:
	self.process_mode = Node.PROCESS_MODE_ALWAYS
	Input.joy_connection_changed.connect(_on_joy_changed)


func _process(_delta: float) -> void:
	move_direction = Input.get_axis("left", "right")


func _input(event: InputEvent) -> void:
	_detect_device_change(event)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("action"):
		action_pressed.emit()
	elif event.is_action_pressed("menu"):
		menu_pressed.emit()
	elif event.is_action_pressed("ui_close_dialog"):
		back_pressed.emit()


func unfocus() -> void:
	get_viewport().gui_release_focus()


func is_controller() -> bool:
	return current_device != DeviceType.KEYBOARD_MOUSE


func _on_joy_changed(device: int, connected: bool) -> void:
	if connected:
		current_device = _detect_pad_type(device)
		device_changed.emit(current_device)


func _detect_device_change(event: InputEvent) -> void:
	if not event is InputEventMouseButton and not _is_bound_action_event(event):
		return

	var new_device: DeviceType = current_device

	if event is InputEventKey or event is InputEventMouseButton:
		new_device = DeviceType.KEYBOARD_MOUSE
	elif event is InputEventJoypadButton:
		new_device = _detect_pad_type(event.device)
	elif event is InputEventJoypadMotion and absf(event.axis_value) > 0.3:
		new_device = _detect_pad_type(event.device)  # deadzone check ignores stick drift

	if new_device != current_device:
		current_device = new_device
		device_changed.emit(current_device)


func _detect_pad_type(device: int) -> DeviceType:
	var info: Dictionary = Input.get_joy_info(device)
	match int(info.get("vendor_id", 0)):
		0x045E:
			return DeviceType.XBOX
		0x054C:
			return DeviceType.PLAYSTATION
		0x057E:
			return DeviceType.NINTENDO
		0x28DE:
			return DeviceType.STEAM

	# Fallback: match on the name
	var device_name: String = Input.get_joy_name(device).to_lower()
	if "xbox" in device_name or "xinput" in device_name:
		return DeviceType.XBOX
	if (
		"ps3" in device_name
		or "ps4" in device_name
		or "ps5" in device_name
		or "playstation" in device_name
		or "dualsense" in device_name
		or "dualshock" in device_name
	):
		return DeviceType.PLAYSTATION
	if "nintendo" in device_name or "switch" in device_name or "joy-con" in device_name:
		return DeviceType.NINTENDO
	if "steam" in device_name:
		return DeviceType.STEAM
	return DeviceType.GENERIC_PAD


func _is_bound_action_event(event: InputEvent) -> bool:
	for action: String in GAME_ACTIONS:
		if event.is_action(action):
			return true
	return false
