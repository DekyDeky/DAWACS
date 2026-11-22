extends StateWorld
class_name StatePlayerAttacking

func enter():
	character.velocity = Vector2.ZERO
	if character.character_sprites:
		character.character_sprites.play("attacking")
	
func exit():
	pass

func physics_update(delta: float) -> void:
	if !character.character_sprites.is_playing():
		if character.character_direction == Vector2.ZERO:
			switch("idle")
		else:
			switch("moving")
