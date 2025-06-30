extends Control
@onready var user_edit = $TextureRect/user_edit
@onready var pass_edit = $TextureRect/pass_edit
@onready var error_label = $TextureRect/error_label
@onready var http_request = $HTTPRequest

func _ready() -> void:
	http_request.request_completed.connect(_on_request_completed)
func _on_login_button_pressed() -> void:
	error_label.visible = false

	var body = {
		"user": user_edit.text,
		"pass": pass_edit.text
	}
	var json_data = JSON.stringify(body)

	http_request.request_raw(
		"http://localhost:4000/login",
		["Content-Type: application/json"],
		HTTPClient.METHOD_POST,
		json_data.to_utf8_buffer()
	)

func _on_request_completed(result, response_code, headers, body):
	if response_code != 200:
		_show_error("Error de conexión con el servidor.")
		return

	var response_text = body.get_string_from_utf8()
	var json = JSON.parse_string(response_text)

	if json and json.has("success") and json["success"] == true:
		print("Login exitoso")

		JuegoState.id_usuario = json["user_id"]
		JuegoState.nombre_usuario = json["nombre"]

		get_tree().change_scene_to_file("res://MascotaSeleccion.tscn")
	else:
		var msg = json.get("message", "Usuario o contraseña incorrectos.")
		_show_error(msg)

func _show_error(msg: String):
	error_label.text = msg
	error_label.visible = true


func _on_register_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Registro.tscn")
