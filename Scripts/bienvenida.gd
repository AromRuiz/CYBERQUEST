extends Control


func _on_boton_comenzar_pressed() -> void:
	get_tree().change_scene_to_file("res://login.tscn")


func _on_button_pressed() -> void:
	OpcionesAudio.show()
