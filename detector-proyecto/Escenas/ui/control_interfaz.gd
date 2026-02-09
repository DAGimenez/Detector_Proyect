extends CanvasLayer

@onready var hojas : Array[Control] = [
	$Control/mochila,
	$Control/misiones_mapa,
	$Control/menu,
]

var posiciones : Array[Vector2] = []
var moviendo : bool = false


func _ready():
	for h in hojas:
		posiciones.append(h.position)
	actualizar_visual()
	pass


func actualizar_visual():
	for i in range(hojas.size()):
		hojas[i].z_index = -i
func actualizar():
	for i in range(hojas.size()):
		var hoja := hojas[i]

		hoja.z_index = -i
	



func siguiente():
	if moviendo: return
	moviendo = true
	var frontal = hojas[0]
	var pos_final = posiciones[hojas.size() - 1]
	var tween = create_tween().set_parallel(false)
	tween.tween_property(frontal, "position", frontal.position + Vector2(200, 0), 0.2).set_trans(Tween.TRANS_CUBIC)
	
	for i in range(1, hojas.size()):
		var sig_tween = create_tween().set_parallel(true)
		sig_tween.tween_property(hojas[i], "position", posiciones[i-1], 0.3).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)

	tween.chain().step_finished # Espera a que termine de salir
	
	var hoja_frontal = hojas.pop_front()
	hojas.push_back(hoja_frontal)
	actualizar_visual()
	
	var vuelta = create_tween()
	vuelta.tween_property(hoja_frontal, "position", pos_final, 0.2).set_trans(Tween.TRANS_CUBIC)
	
	await vuelta.finished
	moviendo = false

func anterior():
	var hoja_fondo = hojas.pop_back()
	hojas.push_front(hoja_fondo)
	actualizar()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("vi_e") and not moviendo:
		siguiente()
	
	if event.is_action_pressed("vi_q"):
		anterior()
