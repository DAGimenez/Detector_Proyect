extends CanvasLayer


@onready var hojas = [
	$Control/menu,
	$Control/misiones_mapa,
	$Control/mochila
]


var pagina_actual : int = 1

func actualizar_hojas():
	for i in hojas.size():
		var hoja = hojas[i]
		var distancia = abs(i - pagina_actual)
		
		hoja.z_index = -distancia
		
		# Corrimiento
		hoja.position = Vector2(
			distancia * 12,
			distancia * 6
		)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("vi_e"):
		pagina_actual = clamp(pagina_actual + 1, 0, hojas.size() - 1)
		actualizar_hojas()
	
	if event.is_action_pressed("vi_q"):
		pagina_actual = clamp(pagina_actual - 1, 0, hojas.size() - 1)
		actualizar_hojas()
