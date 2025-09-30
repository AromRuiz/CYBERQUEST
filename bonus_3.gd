extends Control

@onready var character_button1 = $CharacterButton1
@onready var character_button2 = $CharacterButton2
@onready var score_label = $ScoreLabel
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

	score_label.text = "Puntos: %d" % score
	time_label.text = "Tiempo: %d" % time_left
	show_timer.start()
	game_timer.start()


func _on_button_pressed(button: TextureButton):
	if button.get_meta("is_enemy", true):
		score += 10
	score_label.text = "Puntos: %d" % score
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


func _on_show_timer_timeout() -> void:
	# Decide si aparece solo 1 o los 2
	var spawn_two = randf() < 0.5   # 50% chance de que salgan los dos
	var positions = holes.duplicate()
	positions.shuffle()

	# Botón 1
	var enemy1 = randf() < 0.7
	character_button1.set_meta("is_enemy", enemy1)
	character_button1.texture_normal = preload("res://Recursos/Botones/BO/groo.png") if enemy1 else preload("res://Recursos/Botones/BO/child.png")
	character_button1.global_position = positions.pop_front() - character_button1.size / 2
	character_button1.show()

	# Botón 2 (si toca)
	if spawn_two:
		var enemy2 = randf() < 0.7
		character_button2.set_meta("is_enemy", enemy2)
		character_button2.texture_normal = preload("res://Recursos/Botones/BO/groo.png") if enemy2 else preload("res://Recursos/Botones/BO/child.png")
		character_button2.global_position = positions.pop_front() - character_button1.size / 2
		character_button2.show()
	else:
		character_button2.hide()
