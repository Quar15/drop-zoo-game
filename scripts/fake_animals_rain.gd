extends Node2D

@export var timer: Timer
@export var fake_animal_prefab: PackedScene
@export var max_animals: int = 20

var animal_pool: Array[FakeAnimal]


func _ready() -> void:
	timer.timeout.connect(handle_timer)


func spawn_animal(new_pos: Vector2) -> FakeAnimal:
	var new_animal: FakeAnimal = fake_animal_prefab.instantiate()
	animal_pool.append(new_animal)
	self.add_child(new_animal)
	new_animal.position = new_pos
	new_animal.setup()
	return new_animal


func spawn_or_reuse_animal(new_pos: Vector2) -> void:
	for a: FakeAnimal in animal_pool:
		if not a.is_active:
			a.linear_velocity = Vector2()
			a.new_position = new_pos
			a.setup()
			return

	if len(animal_pool) < max_animals:
		spawn_animal(new_pos)


func handle_timer() -> void:
	spawn_or_reuse_animal(Vector2(randi_range(0, 1920), self.global_position.y))


func _on_deadzone_body_entered(body: Node2D) -> void:
	if not body is FakeAnimal:
		return

	body.is_active = false
	body.visible = false
