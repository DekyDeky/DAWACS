extends StateWorld
class_name StatePlayerIdle

func enter():
	print("Parado")
	character.velocity = Vector2.ZERO
	if character.character_sprites:
		character.character_sprites.play("idle")
	
func exit():
	pass

func physics_update(delta: float) -> void:
	if character.character_direction != Vector2.ZERO and character.active_state is not StatePlayerAttacking:
		switch("moving")
