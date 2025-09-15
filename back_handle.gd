extends Node

# Pila de escenas visitadas
var history: Array[String] = []

func _ready():
	print("Global listo (controlando botón atrás)")

func _unhandled_input(event):
	if event is InputEventKey and event.pressed and event.keycode == KEY_ESCAPE:
		event.consume() # evitar que cierre la app directamente
		_on_back_pressed()

func _on_back_pressed():
	if history.is_empty():
		# Si no hay historial → salir del juego
		get_tree().quit()
	else:
		# Volver a la última escena
		var previous_scene = history.pop_back()
		get_tree().change_scene_to_file(previous_scene)

func go_to_scene(path: String):
	# Guardar la actual antes de cambiar
	if get_tree().current_scene:
		history.append(get_tree().current_scene.scene_file_path)
	get_tree().change_scene_to_file(path)
