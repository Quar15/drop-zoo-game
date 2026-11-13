class_name Animal
extends RigidBody2D

signal touched_animal(a: Animal, b: Animal)
signal touched_ground

@export_category("References")
@export var sprite: Sprite2D
@export var rb_shape: CollisionShape2D
@export var hitbox: Area2D
@export var hit_flash: SpriteHitFlashModule
@export var data: AnimalResource

var is_dirty: bool = false
var is_alive: bool = false
var has_touched_ground: bool = false

var position_dirty: bool = false
var new_position: Vector2:
	set(value):
		new_position = value
		position_dirty = true


func _ready() -> void:
	hitbox.body_entered.connect(_on_hitbox_entered)
	if data:
		setup(data)


func setup(new_data: AnimalResource) -> void:
	is_dirty = true
	is_alive = true

	sprite.scale = Vector2(new_data.size, new_data.size)
	rb_shape.scale = Vector2(new_data.size, new_data.size)

	sprite.texture = new_data.texture
	data = new_data
	is_dirty = false
	has_touched_ground = false
	if OS.is_debug_build():
		printt("@INFO:", self.name, "changed into", data.name)


func _on_hitbox_entered(body: Node2D) -> void:
	if body == self:
		return

	if self.is_dirty:
		return

	if body is DeathArea:
		return

	if body is WallBody:
		return

	if not self.has_touched_ground:
		self.has_touched_ground = true
		touched_ground.emit()

	if not body is Animal:
		return

	if body.is_dirty:
		return

	if body.data.type != self.data.type:
		return

	self.is_dirty = true
	body.is_dirty = true

	touched_animal.emit(self, body)
	AudioManager.create_audio(SoundEffect.Type.ANIMAL_MERGE)

	if OS.is_debug_build():
		printt(self.name, "touched", body.name)


func retrigger_check() -> void:
	hitbox.monitoring = false
	await get_tree().process_frame  # Wait one frame
	hitbox.monitoring = true


func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	if position_dirty:
		state.transform.origin = new_position
		position_dirty = false
