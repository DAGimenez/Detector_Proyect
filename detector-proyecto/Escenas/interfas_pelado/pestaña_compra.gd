extends Control

@onready var text_compra: Label = $VBoxContainer/HBoxContainer/text_compra


var objetos_raros : Dictionary = {
	"collar": 2,
	"cristal": 4
}
var objetos_pedidos : Dictionary = {}
var confianza : int = 0

var intenciones = {
	"halago": ["amigo","hermano","lindo","genial","bueno"],
	"pedido": ["por favor","podrias","podrías","me ayudas","ayuda"],
	"negociacion": ["barato","descuento","rebaja","oferta", "caro"],
	"insulto": ["estafa","robo","ladron","ladrón"]
}

var impacto_intencion = {
	"halago": 3,
	"pedido": 2,
	"negociacion": 1,
	"insulto": -5
}

var precio_base = 2


func _on_line_edit_text_submitted(new_text: String) -> void:
	regatear(new_text)

func regatear(texto_jugador:String):
	var intenciones_detectadas = analizar_texto(texto_jugador)
	var respuesta = responder(intenciones_detectadas)
	var precio_final = calcular_precio(precio_base)
	text_compra.text = respuesta

func analizar_texto(texto:String):
	var palabras = limpiar_texto(texto).split(" ")
	var intenciones_detectadas = []
	for tipo in intenciones.keys():
		for palabra in intenciones[tipo]:
			if palabra in palabras:
				intenciones_detectadas.append(tipo)
				confianza += impacto_intencion[tipo]
	return intenciones_detectadas

func limpiar_texto(texto:String):
	var limpio = texto.to_lower()
	var signos = [".", ",", "!", "?", ";", ":", "¿", "¡"]
	for signo in signos:
		limpio = limpio.replace(signo, "")
	return limpio

func responder(intenciones_detectadas:Array):

	if "insulto" in intenciones_detectadas:
		return "Oye! No me faltes el respeto."

	if "halago" in intenciones_detectadas and "pedido" in intenciones_detectadas:
		return "Bueno... tal vez pueda hacerte un pequeño descuento."

	if "negociacion" in intenciones_detectadas:
		return "Podría bajar un poco el precio."

	if "halago" in intenciones_detectadas:
		return "Me caes bien."

	if "pedido" in intenciones_detectadas:
		return "Veré qué puedo hacer."

	return "No entiendo bien lo que quieres."

func calcular_precio(precio_base:int):
	var precio = precio_base
	if confianza >= 10:
		precio *= 0.7
	elif confianza >= 5:
		precio *= 0.85
	elif confianza <= -5:
		precio *= 1.3
	elif confianza <= -10:
		precio *= 1.5
	return int(precio)
