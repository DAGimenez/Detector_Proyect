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
	var new_objeto_inmovible = objetos_inmovible.instantiate()
	new_objeto_inmovible.texture = objeto.sprite
	new_objeto_inmovible.position = objetos_desenterados.position
	grid_desenterados.add_child(new_objeto_inmovible)
