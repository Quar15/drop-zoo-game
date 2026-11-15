extends Node

@onready var rng: RandomNumberGenerator = RandomNumberGenerator.new()

func is_mobile() -> bool:
	return OS.has_feature("web_android") or OS.has_feature("web_ios")
