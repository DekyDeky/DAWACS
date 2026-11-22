extends Node

@onready var teste : EnemyResource = load("res://resources/enemy_placeholder.tres")

@onready var world : Node2D = $World

@onready var encounter : EnemyResource
@onready var playerStats : Control = $UI/Panel/Player_Stats

@onready var playerCurrentHP : float = GlobalPlayer.player_current_hp
@onready var playerCurrentDefense : float = GlobalPlayer.player_current_defense

@onready var EnemyScene : PackedScene = preload("res://objects/combat/enemy_combat.tscn")

@onready var MinigameLayer : CanvasLayer = $MinigameLayer
@onready var attackMinigame : Resource = preload("res://scenes/minigames/attack_minigame.tscn")

@onready var center : Vector2 = get_viewport().get_visible_rect().size / 2
@onready var enemyDamage : Array[float]

var enemy : Array[EnemyCombat] = []

var rng = RandomNumberGenerator.new()

func _ready() -> void:
	encounter = GlobalCombat.encounter
	enemyDamage = encounter.damage
	print(enemyDamage)
	
	if(GlobalCombat.playerHaveAdvantage):
		GlobalCombat.attackMultiplier = 2.0
	else:
		var initialDamage = round(rng.randf_range(encounter.damage[0], encounter.damage[1]))
		playerCurrentHP -= initialDamage
	
	
	var newEnemy = EnemyScene.instantiate() as EnemyCombat
	newEnemy.resource = encounter
	world.add_child(newEnemy)
	enemy.append(newEnemy)
		
	#lifeBar.get_node("hpLabel").text = (str(teste.max_health) + "/" + str(teste.max_health))
	
	playerStats.get_node("HP").text = ("HP: " + str(playerCurrentHP) + "/" + str(GlobalPlayer.player_max_hp))
	playerStats.get_node("Defense").text = ("Defense: " + str(playerCurrentDefense))
	
	print(center)

func _on_btn_attack_pressed() -> void:
	$UI.hide()
	var newMinimage = attackMinigame.instantiate() as AttackMinigame
	MinigameLayer.add_child(newMinimage)
	await newMinimage.minigameEnded
	$UI.show()
	
	var damage = GlobalPlayer.player_damage * GlobalCombat.attackMultiplier
	enemy[0].reduceHP(damage)
	enemy[0].showLabel(damage)
	
	
