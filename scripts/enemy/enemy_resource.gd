class_name EnemyResource
extends Resource

@export var name: String = "Enemy"
@export var max_health: float = 50.0
@export var speed: float = 300.0
@export var damage : Array[float] = [2.0, 5.0]

@export_group("animationsWorld")
@export var textureIdle: SpriteFrames
@export var textureMovement: SpriteFrames
@export var textureAttack: SpriteFrames

@export_group("animationsCombat")
@export var textureIdleCombat: SpriteFrames
@export var textureAttackCombat: SpriteFrames
@export var textureHabilityCombat: SpriteFrames
