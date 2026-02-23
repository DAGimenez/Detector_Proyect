extends Control

@onready var label: Label = $VBoxContainer/HBoxContainer/VBoxContainer/Label
@onready var total: Label = $VBoxContainer/HBoxContainer/VBoxContainer/total


var productos : Dictionary = {
	"tapa": 5.00,
	"Colgantes de plata" : 30.00,
	"Pedazo de chapa chico": 10.00,
	"Goma de auto": 50.00,
	"Cajita de balas usadas": 15.00,
	"Granada descompuesta": 90.00,
	"Bolsa de tornillos": 20.00
}

var objetos_seleccionados : Array =[]
var precio : float = 0
func _on_venta_button_down() -> void:
	objetos_seleccionados.clear()
	var llaves = productos.keys()
	llaves.shuffle()
	
	var texto_final : String = "Me interesan estos productos:\n"
	var suma_base : float = 0.0

	for i in range(3):
		var nombre_item = llaves[i]
		var precio_item = productos[nombre_item]
		objetos_seleccionados.append({"nombre": nombre_item, "precio": precio_item})
		suma_base += precio_item
		texto_final += nombre_item + ": $" + str(precio_item) + "\n"
	
	var precio_total = suma_base * 1.30
	total.text = "\n-----------------------\n"
	total.text += "Te ofresco : $" + str(precio_total)
	precio = precio_total 
	label.text = texto_final


func _on__button_down() -> void:
	precio = precio * 1.30
	total.text = "\n-----------------------\n"
	total.text += "Te ofresco : $" + str(precio)
	$"..".simpatia -= 5
