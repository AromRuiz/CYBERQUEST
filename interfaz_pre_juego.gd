extends Control
@onready var label_puntaje = $LabelPuntaje

# Referencias a las versiones de cada mascota
@onready var compu_nino       = $TextureRect/compu_nino
@onready var compu_intermedio = $TextureRect/compu_intermedio
@onready var compu_adulto     = $TextureRect/compu_adulto

@onready var celular_nino       = $TextureRect/celular_nino
@onready var celular_intermedio = $TextureRect/celular_intermedio
@onready var celular_adulto     = $TextureRect/celular_adulto

@onready var laptop_nino       = $TextureRect/laptop_nino
@onready var laptop_intermedio = $TextureRect/laptop_intermedio
@onready var laptop_adulto     = $TextureRect/laptop_adulto


func _ready() -> void:
	_ocultar_todas()
	# Mostrar algo inmediatamente (puntos por defecto en JuegoState, normalmente 0)
	_actualizar_mascota(JuegoState.mascota, JuegoState.puntos)
	fetch_puntaje_desde_bd()

func fetch_puntaje_desde_bd():
	var http := HTTPRequest.new()
	add_child(http)
	http.request_completed.connect(_on_http_puntaje_completado)
	var url := "https://api-2-production-12c8.up.railway.app/mis-puntajes/%d" % JuegoState.id_usuario
	print("[DEBUG] Solicitando puntaje -> ", url)
	var err := http.request(url)
	if err != OK:
		push_error("[DEBUG] No se pudo iniciar request: %s" % err)
		# Mostrar mascota por defecto si ni siquiera se pudo iniciar la petición
		_actualizar_mascota(JuegoState.mascota, JuegoState.puntos)

func _on_http_puntaje_completado(_result, code, _headers, body):
	if code == 200:
		var respuesta: Dictionary = JSON.parse_string(body.get_string_from_utf8())
		if respuesta and respuesta.has("success") and respuesta["success"] and respuesta["data"].size() > 0:
			var puntos_bd = int(respuesta["data"][0]["puntaje"])
			JuegoState.puntos = puntos_bd
			label_puntaje.text = "Tu puntaje: " + str(puntos_bd)
			_actualizar_mascota(JuegoState.mascota, puntos_bd)
		else:
			JuegoState.puntos = 0
			label_puntaje.text = "No hay puntaje aún."
			_actualizar_mascota(JuegoState.mascota, 0)
	else:
		label_puntaje.text = "Error al obtener puntaje."

func _actualizar_mascota(mascota: String, puntos: int) -> void:
	_ocultar_todas()
	match mascota:
		"computadora":
			if puntos < 200:
				compu_nino.visible = true
			elif puntos < 300:
				compu_intermedio.visible = true
			else:
				compu_adulto.visible = true
		"celular":
			if puntos < 200:
				celular_nino.visible = true
			elif puntos < 300:
				celular_intermedio.visible = true
			else:
				celular_adulto.visible = true
		"laptop":
			if puntos < 200:
				laptop_nino.visible = true
			elif puntos < 300:
				laptop_intermedio.visible = true
			else:
				laptop_adulto.visible = true


# 🔹 Ocultar todas las mascotas
func _ocultar_todas() -> void:
	for child in $TextureRect.get_children():
		child.visible = false

func _on_empezar_pressed() -> void:
	get_tree().change_scene_to_file("res://preguntasmodulos.tscn")


func _on_boton_tabla_pressed() -> void:
	get_tree().change_scene_to_file("res://Ranking.tscn")


func _on_buttonregresar_pressed() -> void:
	get_tree().change_scene_to_file("res://login.tscn")


func _on_button_bonus_pressed() -> void:
	pass # Replace with function body.
