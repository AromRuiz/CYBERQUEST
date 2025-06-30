extends Control
var preguntas = []
var indice_actual = 0
var puntos = 0
var modulo = JuegoState.modulo_actual
@onready var pregunta_label = $PreguntaLabel
@onready var botones_opciones = [
	$VBoxContainer/Opcion1,
	$VBoxContainer/Opcion2,
	$VBoxContainer/Opcion3,
	$VBoxContainer/Opcion4
]
@onready var feedback_label = $FeedbackLabel

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
	if indice_presionado == correcta:
		puntos += 10
		feedback_label.text = "¡Correcto! +10 puntos"
	else:
		feedback_label.text = "Incorrecto"

	await get_tree().create_timer(1.5).timeout
	indice_actual += 1
	mostrar_pregunta()

func finalizar_modulo(): 
	JuegoState.puntos = puntos
	_enviar_puntaje_y_esperar(puntos, JuegoState.modulo_actual)

func _enviar_puntaje_y_esperar(puntos: int, modulo: int):
	var http = HTTPRequest.new()
	add_child(http)
	http.request_completed.connect(func(_result, response_code, _headers, _body):
		if response_code == 200:
			print("Puntaje guardado con éxito")
		else:
			print("Error al guardar puntaje, código:", response_code)
		# Ahora sí cambiamos de escena
		get_tree().change_scene_to_file("res://resultado.tscn")
	)
	var cuerpo = {
		"id_usuario": JuegoState.id_usuario,
		"modulo": modulo,
		"puntaje": puntos
	}
	var json = JSON.stringify(cuerpo)
	http.request(
		"http://localhost:4000/puntajes",
		["Content-Type: application/json"],
		HTTPClient.METHOD_POST,
		json
	)
