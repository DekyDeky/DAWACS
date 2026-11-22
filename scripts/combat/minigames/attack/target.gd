extends Node2D

var multiplierLabel : Resource = preload("res://scenes/minigames/multiplier.tscn")
var acertouCentro : bool = false

func _on_target_collision_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("ui_mouse_fire"):
		print("Clicou")
		await get_tree().process_frame
		hitTarget()
		showLabel(GlobalCombat.attackMultiplier)
		queue_free()
		


func _on_center_collision_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("ui_mouse_fire"):
		acertouCentro = true	

func hitTarget() -> void:
	if acertouCentro:
		GlobalCombat.attackMultiplier += 0.2
	else:
		GlobalCombat.attackMultiplier += 0.1
		
	

func showLabel(multipler: float) -> void:
	var newMultiplierLabel = multiplierLabel.instantiate() as Label
	newMultiplierLabel.text = ("x " + str(multipler))
	newMultiplierLabel.global_position = global_position + Vector2(13, -62)
	get_tree().current_scene.call_deferred("add_child", newMultiplierLabel)
	
func _on_timer_timeout() -> void:
	queue_free()
