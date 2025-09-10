extends Control
var preguntas = []
var indice_actual = 0
var puntos = 0
var modulo = JuegoState.modulo_actual
@onready var barra_animada = $barraprogreso
@onready var pregunta_label = $FeedbackLabel/TextureRect/PreguntaLabel
@onready var botones_opciones = [
	$VBoxContainer/Opcion1,
	$VBoxContainer/Opcion2,
	$VBoxContainer/Opcion3,
	$VBoxContainer/Opcion4
]
@onready var feedback_label = $FeedbackLabel
@onready var img_correcto = $correcto
@onready var img_incorrecto = $incorrecto
func _ready():
	for i in range(botones_opciones.size()):
		botones_opciones[i].pressed.connect(_on_opcion_presionada.bind(i))
	preguntas = cargar_preguntas(modulo)
	mostrar_pregunta()

func cargar_preguntas(mod: int) -> Array:
	match mod:
		1:
			return Preguntas.preguntas_modulo_1
		2:
			return Preguntas.preguntas_modulo_2
		3:
			return Preguntas.preguntas_modulo_3
		4:
			return Preguntas.preguntas_modulo_4
		5:
			return Preguntas.preguntas_modulo_5
		6:
			return Preguntas.preguntas_modulo_6
		7:
			return Preguntas.preguntas_modulo_7
		8:
			return Preguntas.preguntas_modulo_8
	return []

func mostrar_pregunta():
	if indice_actual >= preguntas.size():
		finalizar_modulo()
		return

	var pregunta_actual = preguntas[indice_actual]
	pregunta_label.text = pregunta_actual["pregunta"]
	await get_tree().process_frame

	for i in range(botones_opciones.size()):
		botones_opciones[i].text = pregunta_actual["opciones"][i]
		botones_opciones[i].disabled = false
		botones_opciones[i].release_focus()
	get_viewport().set_input_as_handled()
	feedback_label.text = ""

func _on_opcion_presionada(indice_presionado: int):
	var correcta = preguntas[indice_actual]["respuesta_correcta"]
	var es_correcta = (indice_presionado == correcta)

	# Actualizar feedback textual y barra
	if es_correcta:
		puntos += 10
		feedback_label.text = "¡Correcto! +10 puntos"
		barra_animada.actualizar_barra(true)
		img_correcto.visible = true
	else:
		feedback_label.text = "Incorrecto"
		barra_animada.actualizar_barra(false)
		img_incorrecto.visible = true

	await get_tree().create_timer(1.2).timeout
	img_correcto.visible = false
	img_incorrecto.visible = false
	indice_actual += 1
	mostrar_pregunta()

func finalizar_modulo(): 
	JuegoState.puntos = puntos
	_enviar_puntaje_y_esperar(puntos, JuegoState.modulo_actual)

func _enviar_puntaje_y_esperar(p_puntos: int, p_modulo: int):
	# 1) Validación sencilla
	if JuegoState.id_usuario <= 0:
		get_tree().change_scene_to_file("res://resultado.tscn")
		return

	# Crear y añadir HTTPRequest
	var http := HTTPRequest.new()
	add_child(http)

	# Conectar señal (4 argumentos)
	http.request_completed.connect(_on_puntaje_guardado)

	# Enviar petición
	var cuerpo := {
		"id_usuario": JuegoState.id_usuario,
		"modulo":     p_modulo,
		"puntaje":    p_puntos
	}
	var err := http.request(
		"https://api-2-production-12c8.up.railway.app/puntajes",
		["Content-Type: application/json"],
		HTTPClient.METHOD_POST,
		JSON.stringify(cuerpo)
	)
	if err != OK:
		push_error("Error al enviar solicitud HTTP: %s" % err)
		get_tree().change_scene_to_file("res://resultado.tscn")

func _on_puntaje_guardado(
	result: int,
	response_code: int,
	headers: PackedStringArray,
	body: PackedByteArray
) -> void:
	# Liberar el nodo HTTPRequest (asume que es el primer hijo HTTPRequest)
	for child in get_children():
		if child is HTTPRequest:
			child.queue_free()
			break

	# Manejo de la respuesta
	if response_code == 200:
		print("Puntaje guardado con éxito")
	else:
		push_error("Falló guardar puntaje, HTTP %d" % response_code)
	get_tree().change_scene_to_file("res://resultado.tscn")


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://preguntasmodulos.tscn")


func _on_button_2_pressed() -> void:
	OpcionesAudio.show()
