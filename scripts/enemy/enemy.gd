extends CharacterBody2D

@onready var player_node: CharacterBody2D = get_tree().get_first_node_in_group("player")
@onready var animated_sprite: AnimatedSprite2D = %sprite
@onready var visao: Node2D = %visao
@onready var attack: Node2D = $Ataque

@export var resource: EnemyResource

var states: Dictionary = {}
var active_state: StateWorld

func _ready() -> void:	
	states["idle"] = StateIdle.new()
	states["chasing"] = StateChasing.new()
	states["attacking"] = StateAttacking.new()
	
	for state in states.values():
		state.character = self
	active_state = states["idle"]
	active_state.enter()
	
	animated_sprite.frame_changed.connect(_on_animated_sprite_2d_frame_changed)

	
func switch_state(state_name: String) -> void:
	active_state = states[state_name]

func _physics_process(delta: float) -> void:
	active_state.physics_update(delta)

func _on_area_2d_body_entered(body: Node2D) -> void:
	print("Tomê-le")
	if body == player_node:
		active_state.switch("attacking")

func _on_enter_area_body_entered(body: Node2D) -> void:
	print("Te vi!")
	if body == player_node:
		active_state.switch("chasing")

func _on_exit_area_body_exited(body: Node2D) -> void:
	print("Cadê?")
	if body == player_node:
		active_state.switch("idle")

func _on_animated_sprite_2d_frame_changed():
	if animated_sprite.sprite_frames == resource.textureAttack and animated_sprite.frame == 5:
		if $Ataque.get_overlapping_bodies().has(player_node):
			enterCombat(false)
			
func _on_sprite_animation_finished() -> void:
	if animated_sprite.sprite_frames == resource.textureAttack:
		active_state.switch("chasing")

func enterCombat(playerHaveAdvantage : bool):
	GlobalCombat.encounter = resource
	
	if(playerHaveAdvantage):
		GlobalCombat.playerHaveAdvantage = true
		
	get_tree().change_scene_to_file("res://scenes/combat.tscn")
	
		
