extends Node
var preguntas_modulo_1 = [
	{
		"pregunta": "¿Qué es la ciberseguridad?",
		"opciones": ["Un antivirus específico", "Un juego en línea", "La práctica de proteger sistemas y datos digitales", "Usar solo redes WiFi públicas"],
		"respuesta_correcta": 2 
	},
	{
		"pregunta": "¿Qué debes hacer si ves un correo sospechoso?",
		"opciones": ["Responder", "Ignorarlo", "Hacer clic en los enlaces", "Reportarlo"],
		"respuesta_correcta": 3
	},
	{
		"pregunta": "¿Qué hace un firewall?",
		"opciones": ["Limpia el disco duro", "Evita que se apague el sistema", "Controla el tráfico de red según reglas de seguridad", "Cifra todos los archivos"],
		"respuesta_correcta": 2
	},
	{
		"pregunta": "¿Qué es un antivirus?",
		"opciones": ["Un sistema de respaldo", "Un programa para instalar juegos", "Un software que detecta y elimina malware", "Un tipo de firewall"],
		"respuesta_correcta": 2
	}
]
var preguntas_modulo_2 = [
	{
		"pregunta": "¿Cuál es una buena práctica al crear contraseñas?",
		"opciones": ["Usar tu nombre", "Usar la misma en todos los sitios", "Mezclar letras, números y símbolos", "Usar solo números"],
		"respuesta_correcta": 2
	},
	{
		"pregunta": "¿Qué es la autenticación de dos factores (2FA)?",
		"opciones": ["Iniciar sesión dos veces", "Confirmar tu identidad con dos métodos distintos", "Escribir dos contraseñas", "Usar un solo dispositivo"],
		"respuesta_correcta": 1
	},
	{
		"pregunta": "¿Qué hace un gestor de contraseñas?",
		"opciones": ["Genera correos", "Recuerda y organiza contraseñas", "Bloquea sitios web", "Detecta virus"],
		"respuesta_correcta": 1
	},
	{
		"pregunta": "¿Qué tipo de contraseña es más segura?",
		"opciones": ["123456", "mariana2020", "Pa$w0rD123!", "contraseña"],
		"respuesta_correcta": 2
	}
]
var preguntas_modulo_3 = [
	{
		"pregunta": "¿Qué es el phishing?",
		"opciones": ["Un tipo de virus", "Engaño para robar datos", "Una red social falsa", "Método para detectar contraseñas"],
		"respuesta_correcta": 1
	},
	{
		"pregunta": "¿Qué técnica consiste en hacerse pasar por alguien más?",
		"opciones": ["Spoofing", "Debugging", "Scanning", "Hashing"],
		"respuesta_correcta": 0
	},
	{
		"pregunta": "¿Cómo identificar un correo sospechoso?",
		"opciones": ["Buena ortografía", "Dirección conocida", "Pide datos personales urgente", "Buen diseño"],
		"respuesta_correcta": 2
	},
	{
		"pregunta": "¿Qué hacer si recibes un correo de phishing?",
		"opciones": ["Responderlo", "Ignorarlo", "Reenviarlo", "Reportarlo"],
		"respuesta_correcta": 3
	}
]
var preguntas_modulo_4 = [
	{
		"pregunta": "¿Qué indica el candado en la barra de direcciones?",
		"opciones": ["Página cerrada", "Buena reputación", "Conexión segura (HTTPS)", "Es una app"],
		"respuesta_correcta": 2
	},
	{
		"pregunta": "¿Qué hacen las cookies?",
		"opciones": ["Eliminar historial", "Mejorar el navegador", "Guardar datos de actividad", "Cifrar información"],
		"respuesta_correcta": 2
	},
	{
		"pregunta": "¿Para qué sirve una VPN?",
		"opciones": ["Acelerar internet", "Proteger identidad en línea", "Borrar correos", "Cambiar contraseña"],
		"respuesta_correcta": 1
	},
	{
		"pregunta": "¿Cómo proteger tu privacidad al navegar?",
		"opciones": ["Usar redes abiertas", "Compartir ubicación", "Revisar permisos y usar navegadores seguros", "Descargar todo"],
		"respuesta_correcta": 2
	}
]
var preguntas_modulo_5 = [
	{
		"pregunta": "¿Qué es el ransomware?",
		"opciones": ["Un juego", "Un virus de anuncios", "Secuestra archivos y pide rescate", "Un antivirus falso"],
		"respuesta_correcta": 2
	},
	{
		"pregunta": "¿Cuál NO es malware?",
		"opciones": ["Spyware", "Gusano", "VPN", "Troyano"],
		"respuesta_correcta": 2
	},
	{
		"pregunta": "¿Qué hace un spyware?",
		"opciones": ["Limpia navegador", "Espía y recopila información", "Mejora batería", "Protege contra virus"],
		"respuesta_correcta": 1
	},
	{
		"pregunta": "¿Qué hacer si tu PC tiene malware?",
		"opciones": ["Ignorarlo", "Instalar más programas", "Analizar con antivirus confiable", "Apagar pantalla"],
		"respuesta_correcta": 2
	}
]
var preguntas_modulo_6 = [
	{
		"pregunta": "¿Qué riesgo hay al instalar apps fuera de la tienda?",
		"opciones": ["Ninguno", "Mayor riesgo de malware", "Aumenta espacio", "Mejora batería"],
		"respuesta_correcta": 1
	},
	{
		"pregunta": "¿Qué es rootear un teléfono?",
		"opciones": ["Repararlo", "Borrar fotos", "Acceso total al sistema", "Apagarlo"],
		"respuesta_correcta": 2
	},
	{
		"pregunta": "¿Qué permisos deben vigilarse?",
		"opciones": ["Acceso a red", "Vibración", "Contactos, micrófono y ubicación", "Cambiar fondo"],
		"respuesta_correcta": 2
	},
	{
		"pregunta": "¿Qué hacer si una app pide permisos innecesarios?",
		"opciones": ["Aceptarlos todos", "Ignorarlos", "Denegarlos si no son necesarios", "Reiniciar teléfono"],
		"respuesta_correcta": 2
	}
]
var preguntas_modulo_7 = [
	{
		"pregunta": "¿Por qué es peligroso compartir mucha información en redes?",
		"opciones": ["Aburre", "Gasta datos", "Pueden suplantarte", "No es peligroso"],
		"respuesta_correcta": 2
	},
	{
		"pregunta": "¿Qué es un perfil falso?",
		"opciones": ["Perfil de empresa", "Cuenta con información falsa", "Sin foto", "Cuenta bloqueada"],
		"respuesta_correcta": 1
	},
	{
		"pregunta": "¿Cómo proteger tu privacidad en redes?",
		"opciones": ["Publicar en modo público", "Aceptar conocidos", "Compartir ubicación", "Ignorar configuraciones"],
		"respuesta_correcta": 1
	},
	{
		"pregunta": "¿Señal de alerta en contacto nuevo?",
		"opciones": ["Foto de perfil", "Pide dinero o datos", "Habla bien", "Muchos seguidores"],
		"respuesta_correcta": 1
	}
]
var preguntas_modulo_8 = [
	{
		"pregunta": "¿Qué es el grooming?",
		"opciones": ["Crear perfiles falsos", "Contactar menores con fines de abuso", "Hackear cuentas", "Usar apps inseguras"],
		"respuesta_correcta": 1
	},
	{
		"pregunta": "¿Qué señal puede indicar grooming?",
		"opciones": ["Felicitaciones", "Juegos", "Adulto que pide secreto", "Publicaciones graciosas"],
		"respuesta_correcta": 2
	},
	{
		"pregunta": "¿Qué hacer si detectas grooming?",
		"opciones": ["Bloquear y reportar", "Ignorarlo", "Borrar app", "Enviar más info"],
		"respuesta_correcta": 0
	},
	{
		"pregunta": "¿Cómo proteger a menores del grooming?",
		"opciones": ["Compartir contraseñas", "Supervisar y educar", "Instalar todo", "Ignorar actividades"],
		"respuesta_correcta": 1
	}
]
