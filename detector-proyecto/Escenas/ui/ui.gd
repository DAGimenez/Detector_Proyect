extends Node2D

var objetos_inmovible = preload("res://Escenas/inventario/objetos_inmovibles/objetos_inmovibles.tscn")
@onready var objetos_usables: PanelContainer = $control_Interfaz/Control/mochila/PanelContainer/MarginContainer/MarginContainer/VBoxContainer/objetos_usables
@onready var objetos_desenterados: PanelContainer = $control_Interfaz/Control/mochila/PanelContainer/MarginContainer/MarginContainer/VBoxContainer/objetos_desenterados
@onready var grid_desenterados: GridContainer = $control_Interfaz/Control/mochila/PanelContainer/MarginContainer/MarginContainer/VBoxContainer/objetos_desenterados/MarginContainer/Grid_desenterados


var rs = preload("res://recursos/collar.tres")
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_up"):
		$control_Interfaz.visible = !$control_Interfaz.visible

	if event.is_action_pressed("ui_down"):
		recolectar_objetos(rs)


func recolectar_objetos(objeto: Resource):
	for slot in grid_desenterados.get_children():
		if slot.get_child_count() > 0:
			var objeto_existente = slot.get_child(0)
			if objeto_existente.get("recurso_del_objeto") == objeto:
				if objeto_existente.has_method("actualizar_cantidad"):
					objeto_existente.actualizar_cantidad(1)
				return
	
	for slot in grid_desenterados.get_children():
		if slot.get_child_count() == 0:
			var new_objeto = objetos_inmovible.instantiate()
			
			new_objeto.texture = objeto.sprite
			new_objeto.recurso_del_objeto = objeto
	
			slot.add_child(new_objeto)
			return
