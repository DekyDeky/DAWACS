extends StateWorld
class_name StateChasing

func enter():
	if character.resource and character.resource.textureMovement:
		character.animated_sprite.sprite_frames = character.resource.textureMovement
		character.animated_sprite.play()
	
func exit():
	pass
	
func physics_update(delta: float) -> void:
	var direction = (character.player_node.global_position - character.global_position).normalized()
	character.velocity = lerp(character.velocity, direction * character.resource.speed, 8.5*delta)
	character.move_and_slide()
	
	if direction.x < 0: character.animated_sprite.flip_h = false
	elif direction.x > 0: character.animated_sprite.flip_h = true
	character.visao.rotation = character.velocity.angle()
	character.attack.rotation = character.velocity.angle()
	
