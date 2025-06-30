extends Control
@onready var label_puntaje = $LabelPuntaje
func _ready() -> void:
	fetch_puntaje_desde_bd()
func fetch_puntaje_desde_bd():
	var http = HTTPRequest.new()
	add_child(http)
	http.request_completed.connect(_on_http_puntaje_completado)
	var url = "http://localhost:4000/mis-puntajes/%d" % JuegoState.id_usuario
	http.request(url)

func _on_http_puntaje_completado(_result, code, _headers, body):
	if code == 200:
		var respuesta = JSON.parse_string(body.get_string_from_utf8())
		if respuesta.success and respuesta.data.size() > 0:
			var puntos_bd = respuesta.data[0].puntaje
			JuegoState.puntos = puntos_bd
			label_puntaje.text = "Tu puntaje: " + str(puntos_bd)
		else:
			label_puntaje.text = "No hay puntaje aún."
	else:
		label_puntaje.text = "Error al obtener puntaje."
func _on_empezar_pressed() -> void:
	get_tree().change_scene_to_file("res://preguntasmodulos.tscn")




func _on_boton_tabla_pressed() -> void:
	get_tree().change_scene_to_file("res://Ranking.tscn")
