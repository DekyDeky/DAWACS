extends StateWorld
class_name StateCombatIdle

func enter():
	print("AWA")
	if characterNode and characterResource and characterResource.textureIdleCombat:
			characterNode.animated_sprite.sprite_frames = characterResource.textureIdleCombat
			characterNode.animated_sprite.play()
	
func exit():
	pass
	
func physics_update(delta: float) -> void:
	pass
