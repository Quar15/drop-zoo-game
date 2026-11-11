extends Node

const GAME_SCENE := preload("uid://384qb3wcvp3c")
const MAIN_MENU_SCENE := preload("uid://cyov0cu38quwl")
const LOADING_SCREEN_PREFAB := preload("uid://cu33xynaskk4n")

var game_world_parent: Node
var loading_screen: LoadingScreen
var curr_scene: Node

func _ready() -> void:
	self.process_mode = Node.PROCESS_MODE_ALWAYS
	game_world_parent = get_tree().root
	loading_screen = LOADING_SCREEN_PREFAB.instantiate()
	loading_screen.process_mode = Node.PROCESS_MODE_ALWAYS
	game_world_parent.add_child.call_deferred(loading_screen)

	var scene_instance = MAIN_MENU_SCENE.instantiate()
	game_world_parent.add_child.call_deferred(scene_instance)
	curr_scene = scene_instance


func load_main_menu() -> void:
	print("@INFO: Loading main menu scene")
	get_tree().paused = false
	loading_screen.animate_show()
	await loading_screen.animation_player.animation_finished
	var scene_instance = MAIN_MENU_SCENE.instantiate()
	game_world_parent.add_child(scene_instance)
	if curr_scene:
		curr_scene.queue_free()
	curr_scene = scene_instance
	loading_screen.animate_hide()
	print("@INFO: Main menu scene loaded")


func load_game() -> void:
	print("@INFO: Loading game scene")
	get_tree().paused = false
	loading_screen.animate_show()
	await loading_screen.animation_player.animation_finished
	var scene_instance = GAME_SCENE.instantiate()
	game_world_parent.add_child(scene_instance)
	if curr_scene:
		curr_scene.queue_free()
	curr_scene = scene_instance
	loading_screen.animate_hide()
	print("@INFO: Game scene loaded")
