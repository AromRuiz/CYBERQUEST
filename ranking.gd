extends Control

@onready var ranking_lista = $RankingLista
@onready var http_request = HTTPRequest.new()
var tema_label = preload("res://Recursos/fuentes/tema_ranking.tres")
func _ready():
	add_child(http_request)
	http_request.request_completed.connect(_on_request_completed)
	http_request.request("https://api-2-production-12c8.up.railway.app/ranking")

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
		label.text = "%s - %d   puntos   (Módulo %d)" % [
			entry["nombre"],
			entry["puntaje"],
			entry["modulo"]
		]
		var fuente_base = tema_label.get_font("font", "Label")
		if fuente_base:
			var fuente_variada = FontVariation.new()
			fuente_variada.base_font = fuente_base
			fuente_variada.spacing_glyph = 6 
			label.add_theme_font_override("font", fuente_variada)
			label.theme = tema_label
			ranking_lista.add_child(label)

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://interfaz_pre_juego.tscn")
