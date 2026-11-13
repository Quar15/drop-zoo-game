class_name NextAnimalGUI
extends VBoxContainer

@export var texture_rect: TextureRect

func setup(data: AnimalResource) -> void:
	texture_rect.texture = data.icon_texture	
