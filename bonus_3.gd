extends Control

@onready var character_button1 = $CharacterButton1
@onready var character_button2 = $CharacterButton2
@onready var time_label = $TimeLabel
@onready var show_timer = $ShowTimer
@onready var game_timer = $GameTimer

var score = 0
var time_left = 20
var holes = []

func _ready():
	randomize()

	# Guardamos posiciones de agujeros decorativos
	for i in range(1, 9):
		var h = get_node("Hole%d" % i)
		holes.append(h.global_position)

	# Configuración inicial
	character_button1.connect("pressed", _on_button_pressed.bind(character_button1))
	character_button2.connect("pressed", _on_button_pressed.bind(character_button2))
	character_button1.hide()
	character_button2.hide()

	time_label.text = "Tiempo: %d" % time_left
	show_timer.start()
	game_timer.start()


func _on_button_pressed(button: TextureButton):
	if button.get_meta("is_enemy", true):
		score += 10
	else:
		score = max(0, score - 5)  # penalización si golpea amigo

	print("Puntaje actual:", score)
	button.hide()


func _on_game_timer_timeout() -> void:
	time_left -= 1
	time_label.text = "Tiempo: %d" % time_left

	if time_left <= 0:
		show_timer.stop()
		game_timer.stop()
		character_button1.hide()
		character_button2.hide()
		time_label.text = "¡Tiempo terminado!"

		# Al finalizar la partida, enviamos el puntaje
		_enviar_puntaje_y_esperar(score, JuegoState.modulo_actual)


func show_with_animation(button: TextureButton, pos: Vector2) -> void:
	button.scale = Vector2(0, 0) # empieza en tamaño 0
	button.global_position = pos - button.size / 2
	button.show()

	var tween = create_tween()
	tween.tween_property(button, "scale", Vector2(1, 1), 0.2).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)


func _on_show_timer_timeout() -> void:
	var spawn_two = randf() < 0.5
	var positions = holes.duplicate()
	positions.shuffle()

	# Botón 1
	var enemy1 = randf() < 0.7
	character_button1.set_meta("is_enemy", enemy1)
	character_button1.texture_normal = preload("res://Recursos/Botones/BO/groo.png") if enemy1 else preload("res://Recursos/Botones/BO/child.png")
	show_with_animation(character_button1, positions.pop_front())

	# Botón 2
	if spawn_two:
		var enemy2 = randf() < 0.7
		character_button2.set_meta("is_enemy", enemy2)
		character_button2.texture_normal = preload("res://Recursos/Botones/BO/groo.png") if enemy2 else preload("res://Recursos/Botones/BO/child.png")
		show_with_animation(character_button2, positions.pop_front())
	else:
		character_button2.hide()


func _enviar_puntaje_y_esperar(p_puntos: int, p_modulo: int):
	if JuegoState.id_usuario <= 0:
		_ir_a_resultado()
		return

	var http := HTTPRequest.new()
	add_child(http)
	http.request_completed.connect(_on_puntaje_guardado)

	var timer := get_tree().create_timer(5.0)
	timer.timeout.connect(func():
		if is_instance_valid(self):
			print("Timeout al guardar puntaje, continuando...")
			_ir_a_resultado()
	)

	var cuerpo := {
		"id_usuario": JuegoState.id_usuario,
		"modulo":     p_modulo,
		"puntaje":    p_puntos
	}
	var err := http.request(
		"http://api-2-production-12c8.up.railway.app/puntajes",
		["Content-Type: application/json"],
		HTTPClient.METHOD_POST,
		JSON.stringify(cuerpo)
	)
	if err != OK:
		push_error("Error al enviar solicitud HTTP: %s" % err)
		_ir_a_resultado()


func _on_puntaje_guardado(result: int, response_code: int, _headers, _body) -> void:
	for child in get_children():
		if child is HTTPRequest:
			child.queue_free()
			break

	if response_code == 200:
		print("Puntaje guardado con éxito")
	else:
		push_error("Falló guardar puntaje HTTP %d" % response_code)

	_ir_a_resultado()


func _ir_a_resultado():
	# Aquí cargas tu escena de resultados
	get_tree().change_scene_to_file("res://extra_resultados.tscn")
