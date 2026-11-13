class_name SpriteHitFlashModule
extends Node

@export var ease_type: Tween.EaseType
@export var trans_type: Tween.TransitionType
@export var anim_duration: float = 0.1
@export var target_color: Color = Color(20, 20, 20)

var tween: Tween
var original_color: Color

@onready var sprite: Node2D = get_parent()


func _ready() -> void:
	original_color = sprite.self_modulate


func play_hit_flash() -> void:
	reset_tween()
	tween.tween_property(sprite, "self_modulate", target_color, anim_duration).from(original_color)
	tween.tween_property(sprite, "self_modulate", original_color, anim_duration)


func reset_tween() -> void:
	if tween:
		tween.kill()

	tween = create_tween().set_ease(ease_type).set_trans(trans_type)
