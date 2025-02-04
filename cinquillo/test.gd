extends Node3D

@export var baraja : Baraja
@export var carta_3d_scene : PackedScene = preload("res://cinquillo/carta_3d.tscn")
@onready var pila: CardCollection3D = $Pila

func _ready() -> void:
	if not baraja:
		push_error('Necesitamos baraja para jugar al cinquillo')
	var instancia_carta : Node3D
	for carta in baraja.cartas:
		instancia_carta = carta_3d_scene.instantiate()
		instancia_carta.initialize(carta)
		pila.append_card(instancia_carta)
	pila.cards.shuffle()
