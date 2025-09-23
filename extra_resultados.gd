extends Control


func _on_boton_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://interfaz_pre_juego.tscn")


func _on_boton_tabla_pressed() -> void:
	get_tree().change_scene_to_file("res://Ranking.tscn")
