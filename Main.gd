extends Node2D

@onready var tileMapLayer: TileMapLayer = $TileMapLayer

func _ready() -> void:
	var texture: Texture2D = load("res://sprites/greentile.png")
	if not texture:
		push_error("Failed to load greentile.png")
		return
	
	createIsometricTileSet(texture)
	fillMap()
	setupCamera()

func createIsometricTileSet(texture: Texture2D) -> void:
	var tileSet: TileSet = TileSet.new()
	
	# Configure for Isometric
	tileSet.tile_shape = TileSet.TILE_SHAPE_ISOMETRIC
	tileSet.tile_layout = TileSet.TILE_LAYOUT_DIAMOND_DOWN
	
	# Set tile size. Isometric grids are typically 2:1 ratio.
	# We use the texture width and half of it for the height.
	var textureSize: Vector2i = texture.get_size()
	tileSet.tile_size = Vector2i(textureSize.x, int(textureSize.x * 0.5))
	
	# Create a TileSetAtlasSource
	var source: TileSetAtlasSource = TileSetAtlasSource.new()
	source.texture = texture
	source.texture_region_size = textureSize
	
	# Create a single tile at (0, 0)
	source.create_tile(Vector2i(0, 0))
	
	# Add the source to the TileSet with ID 0
	tileSet.add_source(source, 0)
	
	# Assign the TileSet to the layer
	tileMapLayer.tile_set = tileSet

func fillMap() -> void:
	for x: int in range(7):
		for y: int in range(4):
			tileMapLayer.set_cell(Vector2i(x, y), 0, Vector2i(0, 0))

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
