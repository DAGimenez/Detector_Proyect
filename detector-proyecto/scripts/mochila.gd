extends Node2D 
class_name Mochila

var objetos: Array [Objetores]= []
# Called when the node enters the scene tree for the first time.

func agregar(objeto: Objetores):
	objetos.append(objeto)

func quitar(objeto: Objetores):
	objetos.erase(objeto)

func tieneobjeto(objeto:Objetores)-> bool:
	return objetos.has(objeto)
