extends Node

class_name TileMapWrapper

var tileMapLayerRef: TileMapLayer

func _init(tileMapLayer: TileMapLayer) -> void:
 tileMapLayerRef = tileMapLayer

func createIsometricTileSet(texture: Texture2D) -> void:
 var tileSet: TileSet = TileSet.new()
 tileSet.tile_shape = TileSet.TILE_SHAPE_ISOMETRIC
 tileSet.tile_layout = TileSet.TILE_LAYOUT_DIAMOND_DOWN
 var textureSize: Vector2i = texture.get_size()
 tileSet.tile_size = Vector2i(textureSize.x, int(textureSize.x * 0.5))
 var source: TileSetAtlasSource = TileSetAtlasSource.new()
 source.texture = texture
 source.texture_region_size = textureSize
 source.create_tile(Vector2i(0, 0))
 tileSet.add_source(source, 0)
 tileMapLayerRef.tile_set = tileSet

func fillMap() -> void:
    for x: int in range(7):
        for y: int in range(4):
            tileMapLayerRef.set_cell(Vector2i(x, y), 0, Vector2i(0, 0))
