class_name Carta
extends Resource

enum Palo {
	BASTOS = 1,
	COPAS = 2,
	ESPADAS = 3,
	OROS = 4
}

enum Rango {
	AS = 1,
	DOS = 2,
	TRES = 3,
	CUATRO = 4,
	CINCO = 5,
	SEIS = 6,
	SIETE = 7,
	SOTA = 8,
	CABALLO = 9,
	REY = 10
}

@export var palo : Palo = Palo.BASTOS
@export var rango : Rango = Rango.AS
@export var front_material : StandardMaterial3D
@export var back_material : StandardMaterial3D

func initialize(p_palo : Palo, p_rango : Rango, p_front_material : StandardMaterial3D, p_back_material : StandardMaterial3D) -> void:
	palo = p_palo
	rango = p_rango
	front_material = p_front_material
	back_material = p_back_material
