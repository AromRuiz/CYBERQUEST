extends Control
@onready var label_puntaje = $LabelPuntaje
func _ready() -> void:
	$TextureRect/compu_nino.visible   = false
	$TextureRect/celular_nino.visible = false
	$TextureRect/laptop_nino.visible  = false
	match JuegoState.mascota:
		"computadora": $TextureRect/compu_nino.visible = true
		"celular"    : $TextureRect/celular_nino.visible = true
		"laptop"     : $TextureRect/laptop_nino.visible = true
	fetch_puntaje_desde_bd()
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
		else:
			label_puntaje.text = "No hay puntaje aún."
	else:
		label_puntaje.text = "Error al obtener puntaje."
func _on_empezar_pressed() -> void:
	get_tree().change_scene_to_file("res://preguntasmodulos.tscn")




func _on_boton_tabla_pressed() -> void:
	get_tree().change_scene_to_file("res://Ranking.tscn")


func _on_buttonregresar_pressed() -> void:
	get_tree().change_scene_to_file("res://login.tscn")
