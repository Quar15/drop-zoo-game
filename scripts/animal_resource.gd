class_name AnimalResource
extends Resource

enum EAnimalType {
	DUCK,
	SNAKE,
	PARROT,
	PENGUIN,
	PIG,
	PANDA,
	COW,
	BEAR,
	HIPPO,
	RHINO,
	ORCA,
}

@export var name: String
@export var texture: Texture2D
@export var size: float
@export var type: EAnimalType
@export var score: int
