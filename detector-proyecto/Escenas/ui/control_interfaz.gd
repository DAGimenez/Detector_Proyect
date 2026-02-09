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
	reorganizar(false)


func reorganizar(animar: bool):
	for i in range(hojas.size()):
		hojas[i].z_index = -i # La primera (0) siempre arriba
		if animar:
			create_tween().tween_property(hojas[i], "position", posiciones[i], 0.25).set_trans(Tween.TRANS_SINE)
		else:
			hojas[i].position = posiciones[i]

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
	var tween = create_tween()
	
	await tween.tween_property(frontal, "position", frontal.position + Vector2(250, 0), 0.15).finished

	hojas.push_back(hojas.pop_front())
	
	reorganizar(true)
	await get_tree().create_timer(0.2).timeout
	moviendo = false
func anterior():
	if moviendo: return
	moviendo = true
	
	var fondo = hojas.back()
	var tween = create_tween()

	await tween.tween_property(fondo, "position", fondo.position + Vector2(250, 0), 0.15).finished

	hojas.push_front(hojas.pop_back())
	
	reorganizar(true)
	await get_tree().create_timer(0.2).timeout
	moviendo = false
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("vi_e"):
		siguiente()
	
	if event.is_action_pressed("vi_q"):
		anterior()

func ir_a_hoja(objetivo: Control):
	if moviendo or hojas[0] == objetivo: return
	var indice_objetivo = hojas.find(objetivo)
	
	for i in range(indice_objetivo):
		await siguiente()

func _on_but_1_button_down() -> void:
	ir_a_hoja($Control/mochila)

func _on_but_2_button_down() -> void:
	ir_a_hoja($Control/misiones_mapa)

func _on_but_3_button_down() -> void:
	ir_a_hoja($Control/menu)
