extends CanvasLayer

@onready var hojas : Array[Control] = [
	$Control/menu,
	$Control/misiones_mapa,
	$Control/mochila
]

var offsets := [
	Vector2(0, 0),
	Vector2(12, 6),
	Vector2(24, 12)
]

var front_pos : Vector2
var tweens := {}


func _ready():
	front_pos = hojas[0].position
	actualizar()


func actualizar():
	for i in hojas.size():
		var hoja := hojas[i]

		hoja.z_index = -i
		var target = front_pos + offsets[i]

		# Matamos tween anterior si existe
		if tweens.has(hoja):
			tweens[hoja].kill()

		var tween := create_tween()
		tween.set_trans(Tween.TRANS_QUAD)
		tween.set_ease(Tween.EASE_OUT)
		tween.tween_property(hoja, "position", target, 0.0)

		tweens[hoja] = tween


func siguiente():
	hojas.push_back(hojas.pop_front())
	actualizar()


func anterior():
	hojas.push_front(hojas.pop_back())
	actualizar()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("vi_e"):
		siguiente()
	
	if event.is_action_pressed("vi_q"):
		anterior()
