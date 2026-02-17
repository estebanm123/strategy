extends Object
class_name AbilityPool

var abilityCreators: Dictionary[Ability.AbilityName, Callable] = {}

func _init() -> void:
	initializeAbilities()

func registerAbility(
	abilityName: Ability.AbilityName,
	intent: String,
	actionCreator: Callable
) -> void:
	abilityCreators[abilityName] = func(actor: Actor, param: float) -> Ability:
		var filledIntent: String = intent.format([param])
		var action: Callable = actionCreator.call(actor, param)
		return Ability.new(abilityName, filledIntent, action, param)

func initializeAbilities() -> void:
	var emptyActionCreator: Callable = func(_actor: Actor, _param: float) -> Callable:
		return func(): pass
	
	registerAbility(
		Ability.AbilityName.BLOCK,
		"Block {0}",
		emptyActionCreator
	)
	
	registerAbility(
		Ability.AbilityName.ATTACK_FRONT,
		"Deal {0} damage to nodes in front",
		emptyActionCreator
	)
	
	var moveActionCreator: Callable = func(actor: Actor, param: float) -> Callable:
		return func():
			var currentPos: Vector2 = actor.position
			var currentTilePos: Vector2i = TileMapWrapper.tileMapLayerRef.local_to_map(currentPos)
			var tilesRight: int = int(param)
			var newTilePos: Vector2i = currentTilePos + Vector2i(tilesRight, 0)
			var newWorldPos: Vector2 = TileMapWrapper.tileMapLayerRef.map_to_local(newTilePos)
			actor.position = newWorldPos
	
	registerAbility(
		Ability.AbilityName.MOVE,
		"Move forward by {0}",
		moveActionCreator
	)

func getAbilityCreator(abilityName: Ability.AbilityName) -> Callable:
	return abilityCreators.get(abilityName)
