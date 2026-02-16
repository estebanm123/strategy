extends Node2D
class_name Actor

var sprite: Sprite2D
var intentLabel: Label
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
    
    intentLabel = Label.new()
    intentLabel.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
    intentLabel.scale = Vector2(0.2, 0.2)
    add_child(intentLabel)

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
    updateIntentLabel(selectedAbility.intent)

func updateIntentLabel(text: String) -> void:
    var wrappedText: String = wrapText(text, 20)
    intentLabel.text = wrappedText
    await Engine.get_main_loop().process_frame
    var labelSize: Vector2 = intentLabel.size
    var scaledWidth: float = labelSize.x * 0.2
    intentLabel.position = Vector2(-scaledWidth / 2.0, -15)

func wrapText(text: String, maxWidth: int) -> String:
    var words: PackedStringArray = text.split(" ")
    var lines: Array[String] = []
    var currentLine: String = ""
    
    for word: String in words:
        var testLine: String = currentLine + word if currentLine == "" else currentLine + " " + word
        if testLine.length() <= maxWidth:
            currentLine = testLine
        else:
            if currentLine != "":
                lines.append(currentLine)
            currentLine = word
    
    if currentLine != "":
        lines.append(currentLine)
    
    return "\n".join(lines)

func executeSelectedAbility() -> void:
    if selectedAbility != null:
        selectedAbility.action.call()
