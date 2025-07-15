extends CanvasLayer
@onready var music_slider = $TextureRect/MusicSlider
@onready var sfx_slider   = $TextureRect/SFXSlider
#func _ready():
	#music_slider.value = db_to_slider(AudioManagers.get_music_db())
	#sfx_slider.value   = db_to_slider(AudioManagers.get_sfx_db())
#
#func _on_MusicSlider_value_changed(value):
	#AudioManagers.set_music_volume(slider_to_db(value))
#
#func _on_SFXSlider_value_changed(value):
	#AudioManagers.set_sfx_volume(slider_to_db(value))
#
#func slider_to_db(value):
	#return lerp(-30, 0, value / 100.0)
#
#func db_to_slider(db):
	#return clamp(((db + 30) / 30.0) * 100.0, 0, 100)

func _on_cerrar_pressed() -> void:
	hide()
