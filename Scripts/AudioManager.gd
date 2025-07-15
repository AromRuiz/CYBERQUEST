extends Node
func set_music_volume(db):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), db)

func set_sfx_volume(db):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), db)

func mute_music(mute: bool):
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Music"), mute)

func mute_sfx(mute: bool):
	AudioServer.set_bus_mute(AudioServer.get_bus_index("SFX"), mute)

func get_music_db():
	return AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music"))

func get_sfx_db():
	return AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX"))
