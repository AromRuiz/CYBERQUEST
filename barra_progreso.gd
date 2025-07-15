extends Control

@onready var barra = $TextureProgressBar
@onready var computadora = $compu
@onready var virus = $virus

var progreso := 0.5

func _ready():
	barra.value = progreso * 100.0
	actualizar_animaciones()

func actualizar_barra(respuesta_correcta: bool):
	if respuesta_correcta:
		progreso += 0.1
	else:
		progreso -= 0.1

	progreso = clamp(progreso, 0.0, 1.0)
	barra.value = progreso * 100.0

	actualizar_animaciones()

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
