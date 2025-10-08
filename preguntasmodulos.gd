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
	
	fetch_modulos_completados()

func _ir_a_preguntas(modulo: int):
	JuegoState.modulo_actual = modulo
	get_tree().change_scene_to_file("res://introduccion.tscn")

func animar_agrandar_achicar(boton):
	var tween = create_tween()
	tween.set_loops()
	tween.tween_property(boton, "scale", Vector2(0.7, 0.7), 1.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(boton, "scale", Vector2(0.6, 0.6), 1.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

# 🔹 Consulta los módulos completados desde la API
func fetch_modulos_completados():
	var http = HTTPRequest.new()
	add_child(http)
	http.request_completed.connect(_on_http_modulos_completados)
	var url = "https://api-2-production-12c8.up.railway.app/modulos-completados/%d" % JuegoState.id_usuario
	http.request(url)

# 🔹 Muestra el check en los módulos completados
func _on_http_modulos_completados(_result, code, _headers, body):
	if code == 200:
		var respuesta = JSON.parse_string(body.get_string_from_utf8())
		if respuesta.success:
			for entry in respuesta.data:
				mostrar_check_modulo(entry.modulo)

func mostrar_check_modulo(modulo_id: int):
	var boton_path = "ScrollContainer/TextureRect/BotonModulo%d" % modulo_id
	if has_node(boton_path):
		var boton = get_node(boton_path)
		if boton.has_node("Check"):
			boton.get_node("Check").visible = true


func _on_button_atras_pressed() -> void:
	get_tree().change_scene_to_file("res://interfaz_pre_juego.tscn")
