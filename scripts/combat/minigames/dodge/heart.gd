extends Node2D
class_name heart

@onready var panel: Panel = get_parent()
@onready var sprite_half_size: float = $Sprite2D.texture.get_width() / 2
@onready var vp_size : Vector2 = get_viewport().get_visible_rect().size
@export var speed: float = 300.0

@onready var bulletObj : PackedScene = preload("res://scenes/minigames/dodge/bullet.tscn")

var panel_limit : Array[float]

func _ready() -> void:

	panel_limit = [0,panel.size[0]]
	
	print(panel_limit)
	print((vp_size[1] - panel.size[1]) / 2)
	print(panel.size)
	

func _process(delta: float) -> void:
	var direction := Input.get_axis("ui_left", "ui_right")
	# Move apenas no eixo horizontal (X)
	position.x += direction * speed * delta
	position.x = clamp(position.x, panel_limit[0]+sprite_half_size, panel_limit[1]-sprite_half_size)
	#print(get_global_transform_with_canvas().origin)
	
func _input(event):
	if event.is_action_pressed("ui_shoot"):
		print("Apertando")
		var selfPosition = get_global_transform_with_canvas().origin
		var newBullet = bulletObj.instantiate()
		newBullet.limit = (vp_size[1] - panel.size[1]) / 2
		newBullet.global_position = Vector2(selfPosition[0] - 96, selfPosition[1] - 75)
		newBullet.panel = panel 
		add_sibling(newBullet)
	


		
	
	
