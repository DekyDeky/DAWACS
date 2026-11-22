extends StateWorld
class_name StateCombatAttacking

func enter():
	if characterNode and characterResource and characterResource.textureAttackCombat:
			characterNode.animated_sprite.sprite_frames = characterResource.textureAttackCombat
			characterNode.animated_sprite.play()
	
func exit():
	pass

func physics_update(delta: float) -> void:
	if !characterNode.animated_sprite.is_playing():
		switch("idle")
