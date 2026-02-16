extends Object
class_name AbilityPool

var abilities: Dictionary = {}

func _init() -> void:
	initializeAbilities()

func initializeAbilities() -> void:
	var emptyAction: Callable = func(): pass
	
	abilities[Ability.AbilityName.BLOCK] = Ability.new(
		Ability.AbilityName.BLOCK,
		"Block {0}",
		emptyAction
	)
	
	abilities[Ability.AbilityName.ATTACK_FRONT] = Ability.new(
		Ability.AbilityName.ATTACK_FRONT,
		"Deal {0} damage to nodes in front",
		emptyAction
	)
	
	abilities[Ability.AbilityName.MOVE] = Ability.new(
		Ability.AbilityName.MOVE,
		"Move forward by {0}",
		emptyAction
	)

func getAbility(abilityName: Ability.AbilityName) -> Ability:
	return abilities.get(abilityName)
