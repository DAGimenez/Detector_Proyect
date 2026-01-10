extends TextureRect



var dragging := false
var offset := Vector2.ZERO
# Referencia al nodo que está por encima de todo
@onready var canvas_layer = get_viewport().get_node("mochila/inventario") 


func _gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			dragging = true
			offset = global_position - get_global_mouse_position()
			
			#Al agarrar, ignoramos el mouse para que no bloquee a los paneles
			mouse_filter = Control.MOUSE_FILTER_IGNORE
			
			var pos_actual = global_position
			get_parent().remove_child(self)
			canvas_layer.add_child(self)
			global_position = pos_actual

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if not event.pressed and dragging:
			dragging = false
			# Restauramos el mouse filter para que se pueda volver a agarrar
			mouse_filter = Control.MOUSE_FILTER_STOP
			colocarse_en_panel_mas_cercano()

func _process(_delta):
	if dragging:
		global_position = get_global_mouse_position() + offset

func colocarse_en_panel_mas_cercano():
	var panels := get_tree().get_nodes_in_group("paneles")
	var mas_cercano : PanelContainer = null
	var distancia_min := INF

	for panel in panels:
		var d = panel.global_position.distance_to(global_position)
		if d < distancia_min:
			distancia_min = d
			mas_cercano = panel

	if mas_cercano:
		get_parent().remove_child(self)
		mas_cercano.add_child(self)
		global_position = mas_cercano.global_position
