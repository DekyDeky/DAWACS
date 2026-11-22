extends CharacterBody2D

@onready var attackArea : Area2D = $Attack
@onready var collision_attack : CollisionShape2D = $Attack/CollisionShape2D

@export var movement_speed : float = 500
var character_direction : Vector2
@onready var character_sprites : AnimatedSprite2D = %sprite
var ataqueAcabou : bool = false

var states: Dictionary = {}
var active_state: StateWorld

func _ready() -> void:	
	states["idle"] = StatePlayerIdle.new()
	states["moving"] = StatePlayerMoving.new()
	states["attacking"] = StatePlayerAttacking.new()
	
	for state in states.values():
		state.character = self
	active_state = states["idle"]
	active_state.enter()
	
func switch_state(state_name: String) -> void:
	active_state = states[state_name]

func _physics_process(delta: float) -> void:
	character_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if character_direction.x > 0: %sprite.flip_h = false
	elif character_direction.x < 0: %sprite.flip_h = true
	
	active_state.physics_update(delta)
	#if character_direction:
	#	velocity = character_direction * movement_speed
	#	%sprite.play("walking")
	#else:
	#	velocity = velocity.move_toward(Vector2.ZERO, movement_speed)
	#	$sprite.play("idle")
	
	#move_and_slide()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_attack"):
		active_state.switch("attacking")
		atacar()
#		print("VAI TOMANDO")
#		%sprite.play("attacking")
#		pass
		
func atacar() -> void:
	var bodies = attackArea.get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("enemy"):
			body.enterCombat(true)
