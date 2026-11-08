class_name Animal
extends RigidBody2D

signal animal_is_merging(a: Animal, b: Animal)
signal animal_touched_ground()

@export_category("References")
@export var sprite: Sprite2D
@export var rb_shape: CollisionShape2D
@export var hitbox: Area2D
@export var hit_flash: SpriteHitFlashModule
@export var data: AnimalResource

var is_dirty: bool = false
var is_alive: bool = false
var touched_ground: bool = false

var position_dirty: bool = false
var new_position: Vector2:
	set(value):
		new_position = value
		position_dirty = true


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hitbox.body_entered.connect(on_hitbox_entered)
	setup(data)  # @TODO: consider removing later


func setup(new_data: AnimalResource) -> void:
	is_dirty = true
	is_alive = true

	sprite.scale = Vector2(new_data.size, new_data.size)
	rb_shape.scale = Vector2(new_data.size, new_data.size)

	sprite.texture = new_data.texture
	data = new_data
	is_dirty = false
	touched_ground = false
	printt("@INFO:", self.name, "changed into", data.name)


func on_hitbox_entered(body: Node2D) -> void:
	if body == self:
		return

	if self.is_dirty:
		return

	if body is DeathArea:
		return

	if body is WallBody:
		return

	if not self.touched_ground:
		self.touched_ground = true
		animal_touched_ground.emit()

	if not body is Animal:
		return

	if body.is_dirty:
		return

	if body.data.type != self.data.type:
		return

	self.is_dirty = true
	body.is_dirty = true

	animal_is_merging.emit(self, body)

	printt(self.name, "touched", body.name)


func retrigger_check():
	hitbox.monitoring = false
	await get_tree().process_frame  # Wait one frame
	hitbox.monitoring = true


func _integrate_forces(state: PhysicsDirectBodyState2D):
	if position_dirty:
		state.transform.origin = new_position
		position_dirty = false
