extends Node

@onready var rng: RandomNumberGenerator = RandomNumberGenerator.new()


func is_instance_of(scene: PackedScene, type: Script) -> bool:
	if scene == null:
		return false

	var current: Script = null

	# finds attached script
	var state: SceneState = scene.get_state()
	var prop_count: int = state.get_node_property_count(0)
	var i: int = 0
	while i < prop_count and current == null:
		if state.get_node_property_name(0, i) == &"script":
			current = state.get_node_property_value(0, i)
		i += 1

	# checks recursively for inheritance
	while current != null:
		if current == type:
			return true
		current = current.get_base_script()
	return false


func get_packed_scene_script(scene: PackedScene) -> Variant:
	var scene_state := scene.get_state()

	for i in scene_state.get_node_property_count(0):
		if scene_state.get_node_property_name(0, i) == "script":
			return scene_state.get_node_property_value(0, i)
	return null
