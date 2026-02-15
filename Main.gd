extends Node2D

@onready var tileMapLayer: TileMapLayer = $TileMapLayer

func _ready() -> void:
	var texture: Texture2D = load("res://sprites/greentile.png")
	if not texture:
		push_error("Failed to load greentile.png")
		return

	TileMapGenerator.createIsometricTileSet(tileMapLayer, texture)
	TileMapGenerator.fillMap(tileMapLayer)
	setupCamera()



func setupCamera() -> void:
	var camera: Camera2D = Camera2D.new()
	camera.zoom = Vector2(4, 4)
	add_child(camera)
	
	var rect: Rect2i = tileMapLayer.get_used_rect()
	if rect.size.x == 0:
		return

	var startPos: Vector2 = tileMapLayer.map_to_local(rect.position)
	var endPos: Vector2 = tileMapLayer.map_to_local(rect.end - Vector2i(1, 1))
	
	camera.position = (startPos + endPos) / 2.0
