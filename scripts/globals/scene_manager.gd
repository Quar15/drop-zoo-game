extends Node

const GAME_SCENE: PackedScene = preload("uid://384qb3wcvp3c")
const MAIN_MENU_SCENE: PackedScene = preload("uid://cyov0cu38quwl")
const LOADING_SCREEN_PREFAB: PackedScene = preload("uid://cu33xynaskk4n")

var game_world_parent: Node
var loading_screen: LoadingScreen
var current_scene: Node

var _is_changing_scene: bool = false


func _ready() -> void:
	self.process_mode = Node.PROCESS_MODE_ALWAYS
	game_world_parent = get_tree().root
	loading_screen = LOADING_SCREEN_PREFAB.instantiate()
	loading_screen.process_mode = Node.PROCESS_MODE_ALWAYS
	game_world_parent.add_child.call_deferred(loading_screen)

	var scene_instance: Node = MAIN_MENU_SCENE.instantiate()
	game_world_parent.add_child.call_deferred(scene_instance)
	current_scene = scene_instance


func load_main_menu() -> void:
	_change_scene(MAIN_MENU_SCENE)


func load_game() -> void:
	_change_scene(GAME_SCENE)


func _change_scene(scene: PackedScene) -> void:
	if _is_changing_scene:
		return

	_is_changing_scene = true
	get_tree().paused = true

	loading_screen.animate_show()
	await loading_screen.animation_player.animation_finished

	if current_scene:
		current_scene.queue_free()
	current_scene = scene.instantiate()
	game_world_parent.add_child(current_scene)

	get_tree().paused = false
	loading_screen.animate_hide()
	_is_changing_scene = false
