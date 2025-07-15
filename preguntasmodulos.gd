extends Control

func _ready():
	for boton in get_tree().get_nodes_in_group("botones"):
		animar_agrandar_achicar(boton)
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
func animar_agrandar_achicar(boton):
	var tween = create_tween()
	tween.set_loops()
	tween.tween_property(boton, "scale", Vector2(0.7, 0.7), 1.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(boton, "scale", Vector2(0.6, 0.6), 1.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)


func _on_button_pressed() -> void:
	OpcionesAudio.show()
