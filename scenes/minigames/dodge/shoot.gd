extends Node2D
class_name bullet

@export var speed: float = 100.0
@export var limit: float
@export var panel : Panel

@export var margem_fade: float = 50.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y += -1 * speed * delta
	var coordenates = get_global_transform_with_canvas().origin
	#print(get_global_transform_with_canvas().origin)
	#print(coordenates[1])
	
	if (coordenates[1] <= limit):
		queue_free()

	# 1. Posição do objeto na tela e retângulo do painel
	var pos_tela: Vector2 = get_global_transform_with_canvas().origin
	var rect_painel: Rect2 = panel.get_global_rect()

	# 2. Calcula quanto o objeto passou para fora de cada borda
	print(rect_painel.position.y)
	print(pos_tela.y)
	var fora_cima: float = rect_painel.position.y - pos_tela.y + 75
	print(fora_cima)
	var fora_baixo: float = pos_tela.y - rect_painel.end.y + 75

	# Pega a maior distância para fora (se <= 0, ainda está dentro do painel)
	var distancia_fora: float = max(0.0, 0.0 , fora_cima, fora_baixo, 0.0)

	# 3. Converte a distância em transparência (1.0 = visível, 0.0 = invisível)
	var alpha: float = 1.0 - clamp(distancia_fora / margem_fade, 0.0, 1.0)
	modulate.a = alpha
