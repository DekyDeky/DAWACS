extends Node2D
class_name EnemyCombat

var multiplierLabel : Resource = preload("res://scenes/minigames/multiplier.tscn")

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var lifeBar : ProgressBar = $hpBar
@onready var lifeBarLabel : Label

@export var resource: EnemyResource
@export var currentHP : float

var states: Dictionary = {}
var active_state: StateWorld

func _ready() -> void:	
	states["idle"] = StateCombatIdle.new()
	states["attack"] = StateCombatAttacking.new()

	for state in states.values():
		state.characterNode = $"."
		state.characterResource = load("res://resources/enemy_placeholder.tres")
		
	active_state = states["attack"]
	active_state.enter()
	
	var enemyTexture = animated_sprite.sprite_frames.get_frame_texture(
		$AnimatedSprite2D.animation, 
		$AnimatedSprite2D.frame
	)
	
	lifeBarLabel = lifeBar.get_node("hpLabel")
	var enemySize = enemyTexture.get_size() * 10.0
	var lifeBarHeight = enemySize[0] / 2
	lifeBar.global_position = Vector2(426, lifeBarHeight)
	currentHP = resource.max_health
	if resource:
		lifeBarLabel.text = (str(currentHP) + "/" + str(resource.max_health))
	
func switch_state(state_name: String) -> void:
	active_state = states[state_name]

func _physics_process(delta: float) -> void:
	active_state.physics_update(delta)
	
func reduceHP(damage : float) -> bool:
	var killedIt = false
	currentHP -= damage
	
	if(currentHP <= 0):
		currentHP = 0
		killedIt = true
		
	var lifeBarProgress = (currentHP / resource.max_health) * 100
	 	
	lifeBar.value = lifeBarProgress
	lifeBarLabel.text = (str(currentHP) + "/" + str(resource.max_health))
	
	return killedIt
	
func showLabel(damage: float) -> void:
	var newMultiplierLabel = multiplierLabel.instantiate() as Label
	newMultiplierLabel.text = (str(damage))
	newMultiplierLabel.global_position = global_position + Vector2(625, 248)
	get_tree().current_scene.call_deferred("add_child", newMultiplierLabel)
