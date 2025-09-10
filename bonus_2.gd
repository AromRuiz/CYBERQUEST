extends Control

var respuesta_correcta = [&"C", &"Arroba", &"C", &"#", &"0", &"R", &"R", &"0"]
var seleccion_actual = []

@onready var barra = $HBoxContainer
@onready var opciones = $GridContainer

func _ready():
	# conectar todos los botones
	for boton in opciones.get_children():
		boton.pressed.connect(_on_opcion_seleccionada.bind(boton))

func _on_opcion_seleccionada(boton):
	# agregar visualmente la figura seleccionada
	var figura = TextureRect.new()
	figura.texture = boton.texture_normal
	figura.custom_minimum_size = Vector2(64, 64)
	figura.expand_mode = TextureRect.EXPAND_IGNORE_SIZE 
	barra.add_child(figura)
	
	# guardar en el array
	seleccion_actual.append(boton.name)
	print("Selección actual:", seleccion_actual)
	
	# verificar progreso
	if seleccion_actual.size() == respuesta_correcta.size():
		if _es_correcto():
			print("¡Correcto! +20 puntos")
			JuegoState.puntos += 20
			_enviar_puntaje_y_esperar(20, JuegoState.modulo_actual)
		else:
			print("Incorrecto, intenta de nuevo")
			reiniciar()
			_ir_a_resultado()

func _es_correcto() -> bool:
	# compara arrays
	return seleccion_actual == respuesta_correcta

func reiniciar():
	seleccion_actual.clear()
	for child in barra.get_children():
		child.queue_free()

func _enviar_puntaje_y_esperar(p_puntos: int, p_modulo: int):
	if JuegoState.id_usuario <= 0:
		_ir_a_resultado()
		return
	
	# Crear y añadir HTTPRequest
	var http := HTTPRequest.new()
	add_child(http)
	http.request_completed.connect(_on_puntaje_guardado)

	# Crear timeout de seguridad (5s)
	var timer := get_tree().create_timer(5.0)
	timer.timeout.connect(func():
		if is_instance_valid(self):
			print("⚠️ Timeout al guardar puntaje (bonus), continuando...")
			_ir_a_resultado()
	)

	# Enviar petición
	var cuerpo := {
		"id_usuario": JuegoState.id_usuario,
		"modulo":     p_modulo,
		"puntaje":    p_puntos
	}
	var err := http.request(
		"http://api-2-production-12c8.up.railway.app/puntajes",
		["Content-Type: application/json"],
		HTTPClient.METHOD_POST,
		JSON.stringify(cuerpo)
	)
	if err != OK:
		push_error("Error al enviar solicitud HTTP: %s" % err)
		_ir_a_resultado()

func _on_puntaje_guardado(
	result: int,
	response_code: int,
	headers: PackedStringArray,
	body: PackedByteArray
) -> void:
	# limpiar HTTPRequest
	for child in get_children():
		if child is HTTPRequest:
			child.queue_free()
			break

	if response_code == 200:
		print("✅ Puntaje bonus guardado con éxito")
	else:
		push_error("Falló guardar puntaje (bonus), HTTP %d" % response_code)

	_ir_a_resultado()

func _ir_a_resultado():
	await get_tree().create_timer(1.0).timeout
	get_tree().change_scene_to_file("res://extra_resultados.tscn")


func _on_button_pressed() -> void:
	OpcionesAudio.show()
