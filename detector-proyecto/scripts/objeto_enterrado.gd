extends Area2D

class_name objeto_enterrado

@export var objeto : Objetores
@onready var sprite: Sprite2D = $Sprite2D
var desenterrado := false
func _ready():
	if objeto:
		sprite.texture = objeto.sprite
func desenterrar():
	if desenterrado:
		return
	
	desenterrado = true
	
	print("Desenterrado:", objeto.nombre)
	
	var player = get_tree().get_first_node_in_group("player")
	if player:
		player.mochila.agregar(objeto)
	
	queue_free()
