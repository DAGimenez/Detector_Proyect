extends Area2D


# Called when the node enters the scene tree for the first time.
@export var scene_to_load : String   # Ruta de la escena a cargar

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			print("Elegiste: ", name)
			get_tree().change_scene_to_file("res://provincia_1.tscn")
