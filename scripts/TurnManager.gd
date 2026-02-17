extends Object
class_name TurnManager

var isPlayerTurn: bool = true
var enemies: Array[Actor] = []
var abilityPool: AbilityPool
var parentNode: Node2D

func _init(
    newAbilityPool: AbilityPool,
    newParentNode: Node2D
) -> void:
    abilityPool = newAbilityPool
    parentNode = newParentNode

func handleInput(event: InputEvent) -> void:
    if event is InputEventKey and event.pressed and not event.echo:
        if event.keycode == KEY_E and isPlayerTurn:
            endPlayerTurn()

func endPlayerTurn() -> void:
    switchToEnemyTurn()
    executeEnemyTurn()

func executeEnemyTurn() -> void:
    for enemy: Actor in enemies:
        enemy.executeSelectedAbility()
    
    for enemy: Actor in enemies:
        enemy.selectNextAbility()
    
    switchToPlayerTurn()

func spawnEnemies() -> void:
    var enemyCount: int = randi_range(1, 3)
    var spawnColumn: int = 0
    var maxRows: int = 4
    
    var availableRows: Array = []
    for y: int in range(maxRows):
        availableRows.append(y)
    
    availableRows.shuffle()
    
    for i: int in range(enemyCount):
        var enemy: Actor = ActorFactory.createEnemyActor(abilityPool)
        if not enemy:
            continue
        
        enemy.selectNextAbility()
        
        var tilePos: Vector2i = Vector2i(spawnColumn, availableRows[i])
        var worldPos: Vector2 = TileMapWrapper.tileMapLayerRef.map_to_local(tilePos)
        enemy.position = worldPos
        parentNode.add_child(enemy)
        enemies.append(enemy)

func switchToEnemyTurn() -> void:
    isPlayerTurn = false

func switchToPlayerTurn() -> void:
    isPlayerTurn = true
