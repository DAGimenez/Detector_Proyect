extends CanvasLayer

@onready var label: Label = $Control/VBoxContainer/Label
@onready var line_edit: LineEdit = $Control/VBoxContainer/LineEdit

var simpatia: float = 50.0 
var esta_hablando: bool = false

var palabras_clave = {
	"por favor": 5, 
	"barato": -2, 
	"estafa": -10, 
	"amigo": 3, 
	"lindo": 5, 
	"gracias": 4, 
	"caro": -5
}

var dinero : int = 500
func _on_line_edit_text_submitted(new_text: String) -> void:
	if new_text == "" or esta_hablando: return
	
	esta_hablando = true
	line_edit.editable = false
	
	var modificador = analizar_texto(new_text)
	actualizar_precios_tienda(modificador)
	
	var respuesta = generar_respuesta(new_text)
	await mostrar_respuesta_paulatina(respuesta)
	
	line_edit.clear()
	line_edit.editable = true
	line_edit.grab_focus()
	esta_hablando = false

func analizar_texto(input_jugador: String) -> float:
	input_jugador = input_jugador.to_lower()
	for palabra in palabras_clave.keys():
		if palabra in input_jugador:
			simpatia += palabras_clave[palabra]
	
	simpatia = clamp(simpatia, 0, 100)
	return remap(simpatia, 0, 100, 1.5, 0.7)

func generar_respuesta(input: String) -> String:
	if simpatia > 80:
		return "¡Eres muy amable! Por ser tú, te haré un precio especial."
	elif simpatia > 50:
		return "Me parece bien, podemos hacer negocios."
	elif simpatia > 20:
		return "Mmm... no me convences, pero supongo que está bien."
	else:
		return "¡Qué insulto! Si no tienes dinero, lárgate de mi tienda."

func mostrar_respuesta_paulatina(texto: String):
	label.text = ""
	for letra in texto:
		label.text += letra
		await get_tree().create_timer(0.03).timeout

func actualizar_precios_tienda(m):
	print("Multiplicador actual: ", m)


func _on_compra_button_down() -> void:
	$PanelContainer.visible = false
	$"pestaña_compra".visible = true
	if dinero <= 300:
		var tx = randf_range(1,2)
		label.text = ""
		if tx == 1:
			label.text = "Te falta guita"
		else:
			label.text = "no, no podes comprarlo, gil"
		
func _on_venta_button_down() -> void:
	$PanelContainer.visible = false
	$"pestaña_venta".visible = true
