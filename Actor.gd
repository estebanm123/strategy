extends Node2D
class_name Actor

var sprite: Sprite2D
var baseMoveSpeed: float = 1.0
var baseDefense: float = 5.0
var baseAttack: float = 10.0
var abilitiesEnum: Array[Ability.AbilityName] = [
	Ability.AbilityName.BLOCK,
	Ability.AbilityName.ATTACK_FRONT,
	Ability.AbilityName.MOVE
]
var selectedAbility: Ability = null
var abilityPool: AbilityPool

func _init(texture: Texture2D, newAbilityPool: AbilityPool) -> void:
	sprite = Sprite2D.new()
	sprite.texture = texture
	sprite.centered = true
	add_child(sprite)
	abilityPool = newAbilityPool

func selectNextAbility() -> void:
	var randomIndex: int = randi() % abilitiesEnum.size()
	var selectedEnum: Ability.AbilityName = abilitiesEnum[randomIndex]
	var creator: Callable = abilityPool.getAbilityCreator(selectedEnum)
	
	var param: float = 0.0
	match selectedEnum:
		Ability.AbilityName.MOVE:
			param = baseMoveSpeed
		Ability.AbilityName.ATTACK_FRONT:
			param = baseAttack
		Ability.AbilityName.BLOCK:
			param = baseDefense
	
	selectedAbility = creator.call(param)

func executeSelectedAbility() -> void:
	if selectedAbility != null:
		selectedAbility.action.call()
