extends Control


func _on_computadora_pressed():
	_seleccionar_mascota("computadora")

func _on_celular_pressed():
	_seleccionar_mascota("celular")

func _on_laptop_pressed():
	_seleccionar_mascota("laptop")

func _seleccionar_mascota(tipo: String):
	var http = HTTPRequest.new()
	add_child(http)
	http.request_completed.connect(func(_r, code, _h, _b):
		if code == 200:
			JuegoState.mascota = tipo
			get_tree().change_scene_to_file("res://interfaz_pre_juego.tscn")
		else:
			print("Error guardando mascota", code)
	)
	var cuerpo = {
		"id_usuario": JuegoState.id_usuario,
		"mascota": tipo
	}
	http.request(
		"http://localhost:4000/guardar_mascota",
		["Content-Type: application/json"],
		HTTPClient.METHOD_POST,
		JSON.stringify(cuerpo)
	)
