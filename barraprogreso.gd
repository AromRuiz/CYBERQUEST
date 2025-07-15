extends Control
@onready var barra = $TextureProgressBar
@onready var computadora = $compu
@onready var virus = $virus
var progreso := 0.5
var computadora_y_original: float
var virus_y_original: float
func _ready():
	barra.value = progreso * 100.0
	computadora_y_original = computadora.global_position.y
	virus_y_original = virus.global_position.y
	actualizar_animaciones()
	actualizar_posiciones()

func actualizar_barra(respuesta_correcta: bool):
	if respuesta_correcta:
		progreso += 0.1
	else:
		progreso -= 0.1

	progreso = clamp(progreso, 0.0, 1.0)
	barra.value = progreso * 100.0

	actualizar_animaciones()
	actualizar_posiciones()

func actualizar_animaciones():
	if progreso >= 0.6:
		computadora.play("feliz")
		virus.play("triste")
	elif progreso <= 0.4:
		computadora.play("triste")
		virus.play("feliz")
	else:
		computadora.play("idle")
		virus.play("idle")
func actualizar_posiciones():
	var barra_size = barra.size * barra.scale
	var barra_global_pos = barra.global_position
	
	# Calcular posición horizontal basada en el progreso
	var pos_x = barra_global_pos.x + (barra_size.x * progreso)
	
	# Obtener el frame actual de los sprites animados
	var compu_texture = computadora.sprite_frames.get_frame_texture(computadora.animation, computadora.frame)
	var virus_texture = virus.sprite_frames.get_frame_texture(virus.animation, virus.frame)
	
	# Calcular ancho de los sprites (considerando escala)
	var compu_width = compu_texture.get_width() * computadora.scale.x
	var virus_width = virus_texture.get_width() * virus.scale.x
	
	# Posicionar computadora (centrada en el punto de progreso)
	computadora.global_position = Vector2(
		pos_x - (compu_width * 0.5),
		computadora_y_original # Ajuste vertical
	)
	
	# Posicionar virus (centrado en el punto de progreso)
	virus.global_position = Vector2(
		pos_x - (virus_width * 0.5),
		virus_y_original  # Ajuste vertical
	)
	
	# Limitar a los bordes de la barra (opcional)
	computadora.global_position.x = clamp(
		computadora.global_position.x,
		barra_global_pos.x,
		barra_global_pos.x + barra_size.x - compu_width
	)
	
	virus.global_position.x = clamp(
		virus.global_position.x,
		barra_global_pos.x,
		barra_global_pos.x + barra_size.x - virus_width
	)
