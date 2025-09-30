extends Control

signal pressed_enemy
signal pressed_friend

@onready var button = $Button
@onready var anim = $AnimationPlayer

var is_enemy = true

func _ready():
	button.pressed.connect(_on_button_pressed)
	hide_mole() # empieza escondido

func show_mole():
	is_enemy = randf() < 0.7  # 70% prob villano
	if is_enemy:
		button.icon = preload("res://Recursos/Botones/BO/groo.png")
	else:
		button.icon = preload("res://Recursos/Botones/BO/child.png")
	anim.play("show")

func hide_mole():
	anim.play("hide")

func _on_button_pressed():
	if is_enemy:
		emit_signal("pressed_enemy")
	else:
		emit_signal("pressed_friend")
	hide_mole()
