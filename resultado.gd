extends Control
@onready var label_puntaje = $LabelPuntaje
@onready var estrellas = [
	$ContenedorEstrellas/TextureRect,
	$ContenedorEstrellas/TextureRect2,
	$ContenedorEstrellas/TextureRect3
]
@onready var boton_menu = $BotonMenu
@onready var boton_tabla = $BotonTabla

func _ready():
	fetch_puntaje_desde_bd()

	boton_menu.pressed.connect(func():
		get_tree().change_scene_to_file("res://preguntasmodulos.tscn")
	)

	boton_tabla.pressed.connect(func():
		get_tree().change_scene_to_file("res://Ranking.tscn")
	)

func fetch_puntaje_desde_bd():
	var http = HTTPRequest.new()
	add_child(http)
	http.request_completed.connect(_on_http_puntaje_completado)
	var url = "https://api-2-production-12c8.up.railway.app/mis-puntajes/%d" % JuegoState.id_usuario
	http.request(url)

func _on_http_puntaje_completado(_result, code, _headers, body):
	if code == 200:
		var respuesta = JSON.parse_string(body.get_string_from_utf8())
		if respuesta.success and respuesta.data.size() > 0:
			var puntos_bd = respuesta.data[0].puntaje
			JuegoState.puntos = puntos_bd
			label_puntaje.text = "Tu puntaje: " + str(puntos_bd)
			mostrar_estrellas(puntos_bd)
		else:
			label_puntaje.text = "No hay puntaje aún."
	else:
		label_puntaje.text = "Error al obtener puntaje."

func mostrar_estrellas(puntos: int):
	var cantidad = calcular_estrellas(puntos)
	for i in range(cantidad):
		estrellas[i].modulate = Color(1, 1, 1, 0)
		var tween = create_tween()
		tween.tween_property(estrellas[i], "modulate:a", 1.0, 0.6).set_delay(i * 0.4)
	for i in range(cantidad, estrellas.size()):
		estrellas[i].modulate = Color(0.5, 0.5, 0.5, 0.4)

func calcular_estrellas(puntos: int) -> int:
	if puntos >= 30:
		return 3
	elif puntos >= 20:
		return 2
	elif puntos >= 10:
		return 1
	return 0
