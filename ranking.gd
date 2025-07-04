extends Control

@onready var ranking_lista = $RankingLista
@onready var http_request = HTTPRequest.new()

func _ready():
	add_child(http_request)
	http_request.request_completed.connect(_on_request_completed)
	http_request.request("http://localhost:4000/ranking")

func _on_request_completed(result, response_code, headers, body):
	if response_code != 200:
		print("Error al obtener ranking")
		return

	var json = JSON.parse_string(body.get_string_from_utf8())
	if not json or not json.has("data"):
		print("Datos de ranking inválidos")
		return

	for entry in json["data"]:
		var label = Label.new()
		label.text = "%s - %d puntos (Módulo %d)" % [
			entry["nombre"],
			entry["puntaje"],
			entry["modulo"]
		]
		ranking_lista.add_child(label)


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://interfaz_pre_juego.tscn")
