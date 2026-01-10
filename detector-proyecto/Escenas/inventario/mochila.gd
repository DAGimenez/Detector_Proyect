extends CanvasLayer

@export var player : Node2D


@onready var grillas: HBoxContainer = $inventario/MarginContainer/VBoxContainer/grillas
@onready var movibles: GridContainer = $inventario/MarginContainer/VBoxContainer/grillas/movibles
@onready var inmovible: GridContainer = $inventario/MarginContainer/VBoxContainer/grillas/inmovible

@onready var slots_principal: HBoxContainer = $inventario/MarginContainer/VBoxContainer/slots_principal
