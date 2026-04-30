extends Node2D
@export var objetos_posibles : Array[Objetores]
@export var cantidad_a_spawnear : int = 20
@export var area_size : Vector2 = Vector2(800, 600)
@export var objeto_escena : PackedScene
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawnear_objetos()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func spawnear_objetos():
	for i in cantidad_a_spawnear:
		var objeto_elegido = elegir_objeto_por_peso()
		var instancia = objeto_escena.instantiate()
		
		instancia.objeto = objeto_elegido
		instancia.global_position = posicion_random_en_area()
		
		add_child(instancia)

func elegir_objeto_por_peso() -> Objetores:
	var total_peso = 0.0
	
	for obj in objetos_posibles:
		total_peso += obj.peso_spawn
	
	var random = randf() * total_peso
	var acumulado = 0.0
	
	for obj in objetos_posibles:
		acumulado += obj.peso_spawn
		if random <= acumulado:
			return obj
	
	return objetos_posibles[0]

func posicion_random_en_area() -> Vector2:
	var x = randf_range(-area_size.x/2, area_size.x/2)
	var y = randf_range(-area_size.y/2, area_size.y/2)
	return global_position + Vector2(x, y)
