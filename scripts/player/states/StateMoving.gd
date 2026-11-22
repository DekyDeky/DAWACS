extends StateWorld
class_name StatePlayerMoving

func enter():
	print("Papope")
	if character.character_sprites:
		print("Andando")
		character.character_sprites.play("walking")
	
func exit():
	pass

func physics_update(delta: float) -> void:
	character.velocity = character.character_direction * character.movement_speed
	character.attackArea.rotation = character.velocity.angle()
	character.move_and_slide()
	
	print("Andadão")
	
	if character.character_direction == Vector2.ZERO:
		switch("idle")
