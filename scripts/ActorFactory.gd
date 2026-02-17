extends Object
class_name ActorFactory

static func createEnemyActor(abilityPool: AbilityPool) -> Actor:
	var enemyTexture: Texture2D = load("res://sprites/placeholder-enemy.png")
	var enemy: Actor = Actor.new(enemyTexture, abilityPool)
	return enemy
