class_name Player
extends Node2D

signal next_animal_selected(animal_resource: AnimalResource)
signal new_animal_spawned(animal: Animal)

@export var spawn_point: Marker2D
@export var animal_sprite: Sprite2D
@export var animal_prefab: PackedScene
@export var animals_parent: Node2D

@export var limiter_left: Marker2D
@export var limiter_right: Marker2D

@export var speed: float = 500

@export var spawn_timer: Timer
@export var spawnable_animal_resources: Array[AnimalResource]

var next_animal_resource: AnimalResource
var current_animal_resource: AnimalResource

var can_drop: bool = true
var is_alive: bool = true


func _ready() -> void:
	next_animal_resource = spawnable_animal_resources[0]

	select_next_animal()
	InputManager.action_pressed.connect(on_drop_action_pressed)
	spawn_timer.timeout.connect(on_spawn_timer_timeout)
	is_alive = true


func _process(delta: float) -> void:
	if not is_alive:
		return

	var move_speed: float = InputManager.move_direction * delta * speed
	global_position.x = clampf(
		global_position.x + move_speed,
		limiter_left.global_position.x,
		limiter_right.global_position.x
	)


func select_next_animal() -> void:
	current_animal_resource = next_animal_resource
	animal_sprite.texture = current_animal_resource.texture
	animal_sprite.scale = Vector2.ONE * current_animal_resource.size

	var rng: int = Global.rng.randi_range(0, spawnable_animal_resources.size() - 1)
	next_animal_resource = spawnable_animal_resources[rng]
	next_animal_selected.emit(next_animal_resource)


func on_drop_action_pressed() -> void:
	if not is_alive or not can_drop or get_tree().paused:
		return
	can_drop = false

	var new_animal: Animal = animal_prefab.instantiate()

	new_animal_spawned.emit(new_animal)
	animals_parent.add_child(new_animal)

	new_animal.new_position = spawn_point.global_position

	new_animal.setup(current_animal_resource)
	select_next_animal()
	spawn_timer.start()


func on_spawn_timer_timeout() -> void:
	can_drop = true
