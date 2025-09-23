extends Control


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Recursos/fuentes/bonus_1.tscn")


func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://bonus_2.tscn")


func _on_button_atras_pressed() -> void:
	get_tree().change_scene_to_file("res://interfaz_pre_juego.tscn")
