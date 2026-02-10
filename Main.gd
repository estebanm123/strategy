extends Node2D

@export_group("Tilemap Settings")
@export var map_width: int = 6
@export var map_height: int = 4
@export var tile_size: Vector2i = Vector2i(28, 14)

@onready var tilemap_layer: TileMapLayer = $TileMapLayer
@onready var camera: Camera2D = $Camera2D

func _ready() -> void:
	setup_isometric_tilemap()
	generate_tilemap()
	center_camera()
	queue_redraw()

func setup_isometric_tilemap() -> void:
	print("=== Setting up tilemap ===")
	if tilemap_layer.tile_set == null:
		var tile_set = TileSet.new()
		tile_set.tile_shape = TileSet.TILE_SHAPE_ISOMETRIC
		tile_set.tile_size = tile_size
		
		var source = TileSetAtlasSource.new()
		var texture = load("res://greentile.png")
		print("Texture loaded: ", texture != null)
		if texture:
			print("Texture size: ", texture.get_size())
		source.texture = texture
		source.texture_region_size = tile_size
		source.create_tile(Vector2i(0, 0))
		tile_set.add_source(source, 0)
		
		tilemap_layer.tile_set = tile_set
		print("TileSet created and assigned")
	else:
		tilemap_layer.tile_set.tile_shape = TileSet.TILE_SHAPE_ISOMETRIC
		tilemap_layer.tile_set.tile_size = tile_size
		print("TileSet already existed, updated shape and size")

func generate_tilemap() -> void:
	tilemap_layer.clear()
	tilemap_layer.scale = Vector2(2, 2)
	var cell_count := 0
	for x in range(map_width):
		for y in range(map_height):
			tilemap_layer.set_cell(Vector2i(x, y), 0, Vector2i(0, 0))
			cell_count += 1
	print("Isometric tilemap generated with size: %d x %d (%d cells)" % [map_width, map_height, cell_count])
	print("TileMapLayer position: ", tilemap_layer.position)
	print("TileMapLayer visible: ", tilemap_layer.visible)
	print("TileMapLayer z_index: ", tilemap_layer.z_index)

func get_world_position(tile_coords: Vector2i) -> Vector2:
	return tilemap_layer.map_to_local(tile_coords)

func get_tile_coords(world_pos: Vector2) -> Vector2i:
	return tilemap_layer.local_to_map(world_pos)

func resize_map(new_width: int, new_height: int) -> void:
	map_width = new_width
	map_height = new_height
	print("Camera position: ", camera.position)
	print("Camera zoom: ", camera.zoom)
	print("Camera enabled: ", camera.enabled)
	generate_tilemap()

func center_camera() -> void:
	var center_tile := Vector2i(map_width / 2, map_height / 2)
	camera.position = tilemap_layer.map_to_local(center_tile)
