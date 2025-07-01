extends Control

func _ready():
	$ScrollContainer/TextureRect/BotonModulo1.pressed.connect(func(): _ir_a_preguntas(1))
	$ScrollContainer/TextureRect/BotonModulo2.pressed.connect(func(): _ir_a_preguntas(2))
	$ScrollContainer/TextureRect/BotonModulo3.pressed.connect(func(): _ir_a_preguntas(3))
	$ScrollContainer/TextureRect/BotonModulo4.pressed.connect(func(): _ir_a_preguntas(4))
	$ScrollContainer/TextureRect/BotonModulo5.pressed.connect(func(): _ir_a_preguntas(5))
	$ScrollContainer/TextureRect/BotonModulo6.pressed.connect(func(): _ir_a_preguntas(6))
	$ScrollContainer/TextureRect/BotonModulo7.pressed.connect(func(): _ir_a_preguntas(7))
	$ScrollContainer/TextureRect/BotonModulo8.pressed.connect(func(): _ir_a_preguntas(8))

func _ir_a_preguntas(modulo: int):
	JuegoState.modulo_actual = modulo
	get_tree().change_scene_to_file("res://introduccion.tscn")
