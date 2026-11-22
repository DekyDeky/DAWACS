extends Node
class_name AttackMinigame

var Target : Resource = preload("res://scenes/minigames/target.tscn")
var targetContainer : Node2D
var targetTimer : Timer

var panel : Panel

var howManyTargets : int = 0

signal minigameEnded

func _ready() -> void:
	panel = $Control/Panel
	targetContainer = $TargetContainer
	targetTimer = $CreateTargetTimer
	print(panel.position)

func _on_timer_timeout() -> void:
	var rng = RandomNumberGenerator.new()
	
	var x = randf_range(panel.position[0] + 50.0, panel.size[0] + panel.position[0] - 50.0)
	var y = randf_range(panel.position[1] + 50.0, panel.size[1] + panel.position[1] - 50.0)
	
	var newTarget = Target.instantiate() as Node2D
	newTarget.global_position = Vector2(x, y)
	targetContainer.add_child(newTarget)
	
	howManyTargets += 1
	print(howManyTargets)
	
func _physics_process(delta: float) -> void:
	if howManyTargets >= 10:
		targetTimer.stop()
		await get_tree().create_timer(2.0).timeout
		minigameEnded.emit()
		queue_free()
	
