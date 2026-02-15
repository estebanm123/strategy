extends Node2D
class_name Actor

var sprite: Sprite2D

func _init(texture: Texture2D) -> void:
	sprite = Sprite2D.new()
	sprite.texture = texture
	sprite.centered = true
	add_child(sprite)
