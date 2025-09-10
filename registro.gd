extends Control

@onready var user_edit = $TextureRect/user_edit
@onready var pass_edit = $TextureRect/pass_edit
@onready var error_label = $TextureRect/error_label
@onready var http_request = $HTTPRequest
@onready var register_button = $TextureRect/CrearButton
@onready var login_button = $TextureRect/LoginButton

func _ready():
	http_request.request_completed.connect(_on_request_completed)
	register_button.pressed.connect(_on_register_button_pressed)
	login_button.pressed.connect(_on_login_button_pressed)

func _on_register_button_pressed():
	error_label.visible = false

	var user = user_edit.text.strip_edges()
	var password = pass_edit.text.strip_edges()

	if user.is_empty() or password.is_empty():
		_show_error("Completa ambos campos.")
		return

	var body = {
		"user": user,
		"pass": password
	}

	var json_data = JSON.stringify(body)

	http_request.request_raw(
		"https://api-2-production-12c8.up.railway.app/register",
		["Content-Type: application/json"],
		HTTPClient.METHOD_POST,
		json_data.to_utf8_buffer()
	)

func _on_request_completed(result, response_code, headers, body):
	if response_code != 200:
		_show_error("Error del servidor.")
		return

	var response_text = body.get_string_from_utf8()
	var json = JSON.parse_string(response_text)

	if json and json.has("success"):
		if json["success"]:
			_show_error("Usuario registrado con éxito.", true)
		else:
			var msg = json.get("message", "Registro fallido.")
			_show_error(msg)
	else:
		_show_error("Respuesta inválida del servidor.")

func _on_login_button_pressed():
	get_tree().change_scene_to_file("res://login.tscn")

func _show_error(msg: String, success := false):
	error_label.text = msg
	error_label.modulate = Color.GREEN if success else Color.RED
	error_label.visible = true
