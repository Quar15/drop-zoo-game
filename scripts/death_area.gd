class_name DeathArea
extends Area2D


func retrigger_check() -> void:
	self.monitoring = false
	await get_tree().process_frame  # Wait one frame
	self.monitoring = true
