extends Label

func _ready() -> void:
	var multiplerLabelTween = get_tree().create_tween()
	multiplerLabelTween.set_parallel(true)
	multiplerLabelTween.tween_property(self, "scale", Vector2(0.7, 0.7), 0.2)
	multiplerLabelTween.tween_property(self, "scale", Vector2.ZERO, 0.5).set_delay(0.4)
	multiplerLabelTween.tween_property(self, "position:y", global_position.y - 80, 2.0).set_delay(0.4)
	await multiplerLabelTween.finished
	queue_free()
