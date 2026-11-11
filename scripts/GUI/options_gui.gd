class_name OptionsGUI
extends Control

@export var back_btn: Button
@export var music_slider: Slider
@export var sfx_slider: Slider
@export var fullscreen_checkbtn: CheckButton

@export var music_bus_name: String
var music_bus_index: int

@export var sfx_bus_name: String
var sfx_bus_index: int


func _ready() -> void:
	music_bus_index = AudioServer.get_bus_index(music_bus_name)
	sfx_bus_index = AudioServer.get_bus_index(sfx_bus_name)

	back_btn.mouse_entered.connect(on_btn_hover)
	music_slider.mouse_entered.connect(on_btn_hover)
	sfx_slider.mouse_entered.connect(on_btn_hover)
	fullscreen_checkbtn.mouse_entered.connect(on_btn_hover)

	back_btn.pressed.connect(on_btn_click)
	music_slider.drag_started.connect(on_btn_click)
	sfx_slider.drag_started.connect(on_btn_click)
	fullscreen_checkbtn.pressed.connect(on_btn_click)

	back_btn.pressed.connect(back)
	music_slider.value_changed.connect(on_music_value_changed)
	sfx_slider.value_changed.connect(on_sfx_value_changed)
	fullscreen_checkbtn.toggled.connect(on_fullscreen_button_toggled)


func show_up() -> void:
	music_slider.value = db_to_linear(AudioServer.get_bus_volume_db(music_bus_index))
	sfx_slider.value = db_to_linear(AudioServer.get_bus_volume_db(sfx_bus_index))
	fullscreen_checkbtn.button_pressed = (
		DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN
	)
	self.visible = true
	self.mouse_filter = Control.MOUSE_FILTER_STOP


func back() -> void:
	self.visible = false
	self.mouse_filter = Control.MOUSE_FILTER_IGNORE


func on_music_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(music_bus_index, linear_to_db(value))


func on_sfx_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(sfx_bus_index, linear_to_db(value))


func on_fullscreen_button_toggled(status: bool) -> void:
	if status == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func on_btn_hover() -> void:
	AudioManager.create_audio(SoundEffect.SOUND_EFFECT_TYPE.UI_HOVER)


func on_btn_click() -> void:
	AudioManager.create_audio(SoundEffect.SOUND_EFFECT_TYPE.UI_CLICK)
