extends Node2D
class_name heart

@onready var panel: Panel = get_parent()
@onready var sprite_half_size: float = $Sprite2D.texture.get_width() / 2
@onready var vp_size : Vector2 = get_viewport().get_visible_rect().size
@export var speed: float = 300.0

var panel_limit : Array[float]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	
	panel_limit = [0,panel.size[0]]
	
	print(panel_limit)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var direction := Input.get_axis("ui_left", "ui_right")
	# Move apenas no eixo horizontal (X)
	position.x += direction * speed * delta
	
	position.x = clamp(position.x, panel_limit[0]+sprite_half_size, panel_limit[1]-sprite_half_size)
	print(position.x)
		
	
	
