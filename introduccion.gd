extends Control

@onready var texture_rects := [
	$TextureRect2,
	$TextureRect3,
	$TextureRect4
]

@onready var labels := [
	$TextureRect2/Label,
	$TextureRect3/Label,
	$TextureRect4/Label
]

@onready var boton_continuar := $BotonContinuar

var parrafos : Array = []
var indice_actual := 0
var modulo :int = JuegoState.modulo_actual 

func _ready():
	parrafos = obtener_parrafos_modulo(modulo)

	for rect in texture_rects:
		rect.visible = false

	boton_continuar.pressed.connect(_on_BotonContinuar_pressed)

	_on_BotonContinuar_pressed()

func _on_BotonContinuar_pressed():
	if indice_actual >= parrafos.size():
		get_tree().change_scene_to_file("res://preguntas_opciones.tscn")
		return

	var label = labels[indice_actual]
	label.text = parrafos[indice_actual]
	var rect = texture_rects[indice_actual]
	rect.visible = true
	rect.modulate.a = 0.0  # Empieza invisible

	# Animación de fade-in
	var tween = create_tween()
	tween.tween_property(rect, "modulate:a", 1.0, 0.6).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

	indice_actual += 1


func obtener_parrafos_modulo(mod: int) -> Array:
	match mod:
		1:
			return [
				"La ciberseguridad es el conjunto de prácticas para proteger sistemas informáticos.",
				"Implica proteger datos personales, redes y dispositivos frente a amenazas.",
				"Es fundamental para prevenir ataques como el robo de información o malware."
			]
		2:
			return [
				"Las contraseñas son una primera barrera de protección digital.",
				"Una contraseña segura debe combinar letras, números y símbolos.",
				"La autenticación de dos factores refuerza aún más la seguridad."
			]
		3:
			return [
				"El phishing es una técnica de engaño utilizada por ciberdelincuentes.",
				"Suelen hacerse pasar por empresas legítimas para obtener tus credenciales.",
				"Aprender a identificar estos intentos puede evitar grandes problemas."
			]
		4:
			return [
				"La privacidad en línea es clave para proteger tu información personal.",
				"El uso de HTTPS, ajustes de privacidad y VPN son buenas prácticas.",
				"Controlar las cookies y permisos ayuda a mantener tu navegación segura."
			]
		5:
			return [
				"El malware es software malicioso que puede dañar tu dispositivo.",
				"Existen diferentes tipos como virus, troyanos, ransomware y spyware.",
				"Un buen antivirus y prácticas seguras ayudan a prevenir infecciones."
			]
		6:
			return [
				"Las aplicaciones móviles pueden ser una fuente de riesgo si no se eligen bien.",
				"Instalar apps desde tiendas oficiales y revisar sus permisos es esencial.",
				"Evita dar acceso innecesario a micrófono, ubicación o contactos."
			]
		7:
			return [
				"Las redes sociales pueden exponer mucha información personal.",
				"Compartir demasiado puede ponerte en riesgo de suplantación o engaños.",
				"Configura bien tu privacidad y limita lo que publicas o con quién interactúas."
			]
		8:
			return [
				"El grooming ocurre cuando adultos contactan menores con fines inapropiados.",
				"Suelen ganarse su confianza y pedirles mantener secretos.",
				"Es clave educar, supervisar y denunciar cualquier señal de esta conducta."
			]
		_:
			return []
