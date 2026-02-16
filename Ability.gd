extends Object
class_name Ability

enum AbilityName {
	BLOCK,
	ATTACK_FRONT,
	MOVE
}

var abilityName: AbilityName
var intent: String
var action: Callable
var param0: float = 0.0

func _init(
	newAbilityName: AbilityName,
	newIntent: String,
	newAction: Callable,
	newParam0: float = 0.0
) -> void:
	abilityName = newAbilityName
	intent = newIntent
	action = newAction
	param0 = newParam0
