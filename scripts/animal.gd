extends Node2D

@export var hit_flash: SpriteHitFlashModule

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _input(event: InputEvent) -> void:
	# @TODO: Get rid of it when no longer needed - just an example usage
	if event.is_action_pressed("action"):
		hit_flash.play_hit_flash()
