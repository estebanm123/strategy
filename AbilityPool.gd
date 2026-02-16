extends Object
class_name AbilityPool

var abilityCreators: Dictionary[Ability.AbilityName, Callable] = {}

func _init() -> void:
	initializeAbilities()

func registerAbility(
	abilityName: Ability.AbilityName,
	intent: String,
	action: Callable
) -> void:
	abilityCreators[abilityName] = func(param: float) -> Ability:
		var filledIntent: String = intent.format([param])
		return Ability.new(abilityName, filledIntent, action, param)

func initializeAbilities() -> void:
	var emptyAction: Callable = func(): pass
	
	registerAbility(
		Ability.AbilityName.BLOCK,
		"Block {0}",
		emptyAction
	)
	
	registerAbility(
		Ability.AbilityName.ATTACK_FRONT,
		"Deal {0} damage to nodes in front",
		emptyAction
	)
	
	registerAbility(
		Ability.AbilityName.MOVE,
		"Move forward by {0}",
		emptyAction
	)

func getAbilityCreator(abilityName: Ability.AbilityName) -> Callable:
	return abilityCreators.get(abilityName)
