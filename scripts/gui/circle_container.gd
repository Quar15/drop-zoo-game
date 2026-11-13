class_name CircleContainer
extends Control

@export var radius: float = 200.0

@export var element_size: Vector2 = Vector2(64, 64)

@export var elements: Array[TextureRect] = []


func _ready() -> void:
	create_circle()


func create_circle() -> void:
	# Calculate required container size
	var diameter: float = radius * 2.0 + element_size.x
	var diameter_y: float = radius * 2.0 + element_size.y
	custom_minimum_size = Vector2(diameter, diameter_y)

	var center: Vector2 = custom_minimum_size / 2.0

	var element_count: int = len(elements)
	var i: int = 0
	for element: TextureRect in elements:
		element.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		element.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		element.custom_minimum_size = element_size
		element.size = element_size

		# Calculate angle
		var angle: float = (TAU / element_count) * i - PI / 2

		# Calculate position
		var x: float = center.x + cos(angle) * radius
		var y: float = center.y + sin(angle) * radius

		# Center the TextureRect on its calculated position
		element.position = Vector2(x, y) - element_size / 2.0
		i += 1
