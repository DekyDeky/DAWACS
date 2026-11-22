extends StateWorld
class_name StateAttacking

func enter():
	character.velocity = Vector2.ZERO
	if character.resource and character.resource.textureAttack:
			character.animated_sprite.sprite_frames = character.resource.textureAttack
			character.animated_sprite.play()
	
func exit():
	pass

func physics_update(delta: float) -> void:
	pass
