extends StateWorld
class_name StateIdle

func enter():
	character.velocity = Vector2.ZERO
	if character.resource and character.resource.textureIdle:
			character.animated_sprite.sprite_frames = character.resource.textureIdle
			character.animated_sprite.play()
	
func exit():
	pass
	
func physics_update(delta: float) -> void:
	pass
