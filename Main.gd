extends Node2D


@onready var tileMapWrapper: TileMapWrapper = TileMapWrapper.new($TileMapLayer)

var abilityPool: AbilityPool
var turnManager: TurnManager

func _ready() -> void:
    abilityPool = AbilityPool.new()
    turnManager = TurnManager.new(tileMapWrapper, abilityPool, self)
    
    var texture: Texture2D = load("res://sprites/greentile.png")
    if not texture:
        push_error("Failed to load greentile.png")
        return

    tileMapWrapper.createIsometricTileSet(texture)
    tileMapWrapper.fillMap()
    setupCamera()
    turnManager.spawnEnemies()

func _unhandled_input(event: InputEvent) -> void:
    turnManager.handleInput(event)

func setupCamera() -> void:
    var camera: Camera2D = Camera2D.new()
    camera.zoom = Vector2(4, 4)
    add_child(camera)

    var rect: Rect2i = tileMapWrapper.tileMapLayerRef.get_used_rect()
    if rect.size.x == 0:
        return

    var startPos: Vector2 = tileMapWrapper.tileMapLayerRef.map_to_local(rect.position)
    var endPos: Vector2 = tileMapWrapper.tileMapLayerRef.map_to_local(rect.end - Vector2i(1, 1))

    camera.position = (startPos + endPos) / 2.0
