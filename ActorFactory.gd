extends Object
class_name ActorFactory

const FRIENDLY_SPRITE_PATH: String = "res://sprites/placeholder-friendly.png"
const ENEMY_SPRITE_PATH: String = "res://sprites/placeholder-enemy.png"

static func createFriendlyActor(abilityPool: AbilityPool) -> Actor:
	var texture: Texture2D = load(FRIENDLY_SPRITE_PATH)
	if not texture:
		push_error("Failed to load friendly sprite")
		return null
	return Actor.new(texture, abilityPool)

static func createEnemyActor(abilityPool: AbilityPool) -> Actor:
	var texture: Texture2D = load(ENEMY_SPRITE_PATH)
	if not texture:
		push_error("Failed to load enemy sprite")
		return null
	return Actor.new(texture, abilityPool)
