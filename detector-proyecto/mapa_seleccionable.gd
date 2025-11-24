extends Control
const Provincia_1 := ("res://Escenas/provincia_1.tscn")
const Provincia_2 := ("res://Escenas/provincia_2.tscn")

# Called when the node enters the scene tree for the first time.
func _on_provincia2_pressed() -> void:
	
	get_tree().change_scene_to_file("res://Escenas/provincia_1.tscn")


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file(Provincia_1)


func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file(Provincia_2)
