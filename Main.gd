extends Node2D


@onready var tileMapWrapper: TileMapWrapper = TileMapWrapper.new($TileMapLayer)

func _ready() -> void:
 var texture: Texture2D = load("res://sprites/greentile.png")
 if not texture:
  push_error("Failed to load greentile.png")
  return

 tileMapWrapper.createIsometricTileSet(texture)
 tileMapWrapper.fillMap()
 setupCamera()
 spawnEnemies()



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


func spawnEnemies() -> void:
 var enemyCount: int = randi_range(1, 3)
 var spawnColumn: int = 0
 var maxRows: int = 4
 
 var availableRows: Array = []
 for y: int in range(maxRows):
  availableRows.append(y)
 
 availableRows.shuffle()
 
 for i: int in range(enemyCount):
  var enemy: Actor = ActorFactory.createEnemyActor()
  if not enemy:
   continue
  
  var tilePos: Vector2i = Vector2i(spawnColumn, availableRows[i])
  var worldPos: Vector2 = tileMapWrapper.tileMapLayerRef.map_to_local(tilePos)
  enemy.position = worldPos
  add_child(enemy)
