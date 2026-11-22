@abstract
extends Resource
class_name StateWorld

var character: CharacterBody2D = null
var characterNode : Node2D = null
var characterResource : EnemyResource = null

@abstract
func enter()

@abstract
func exit()

func switch(state_name: String):
	if character:
		character.active_state.exit()
		character.switch_state(state_name)
		character.active_state.enter()
	elif characterNode:
		characterNode.active_state.exit()
		characterNode.switch_state(state_name)
		characterNode.active_state.enter()
