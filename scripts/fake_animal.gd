class_name FakeAnimal
extends RigidBody2D

@export var min_rotation_velocity: float = -60
@export var max_rotation_velocity: float = 60
var rotation_speed: float = 0

@export var sizes: Array[float] = []
@export var sprites: Array[Texture2D] = []

@export_category("References")
@export var sprite: Sprite2D
@export var collision_shape: CollisionShape2D

var is_active: bool = false
var last_rng: int = -1

var position_dirty: bool = false
var new_position: Vector2:
	set(value):
		new_position = value
		position_dirty = true


func _ready() -> void:
	setup()


func setup() -> void:
	is_active = true
	rotation_speed = randf_range(min_rotation_velocity, max_rotation_velocity)

	var rng: int = randi_range(0, len(sizes) - 1)
	if rng == last_rng:
		rng = randi_range(0, len(sizes) - 1)
	last_rng = rng

	sprite.texture = sprites[rng]
	sprite.scale = Vector2(sizes[rng], sizes[rng])
	collision_shape.scale = Vector2(sizes[rng], sizes[rng])

	self.visible = true


func _process(delta: float) -> void:
	if not is_active:
		return
	sprite.rotation += deg_to_rad(rotation_speed) * delta


func _integrate_forces(state: PhysicsDirectBodyState2D):
	if position_dirty:
		state.transform.origin = new_position
		position_dirty = false
