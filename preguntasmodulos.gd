extends Control

func _ready():
	$GridContainer/BotonModulo1.pressed.connect(func(): _ir_a_preguntas(1))
	$GridContainer/BotonModulo2.pressed.connect(func(): _ir_a_preguntas(2))
	$GridContainer/BotonModulo3.pressed.connect(func(): _ir_a_preguntas(3))
	$GridContainer/BotonModulo4.pressed.connect(func(): _ir_a_preguntas(4))
	$GridContainer/BotonModulo5.pressed.connect(func(): _ir_a_preguntas(5))
	$GridContainer/BotonModulo6.pressed.connect(func(): _ir_a_preguntas(6))
	$GridContainer/BotonModulo7.pressed.connect(func(): _ir_a_preguntas(7))
	$GridContainer/BotonModulo8.pressed.connect(func(): _ir_a_preguntas(8))

func _ir_a_preguntas(modulo: int):
	JuegoState.modulo_actual = modulo
	get_tree().change_scene_to_file("res://introduccion.tscn")
