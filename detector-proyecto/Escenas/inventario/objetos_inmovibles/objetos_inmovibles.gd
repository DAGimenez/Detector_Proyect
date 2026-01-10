extends TextureRect


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
