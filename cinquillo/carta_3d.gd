class_name Carta3D
extends Card3D

var _data : Carta
@onready var card_back: MeshInstance3D = $CardMesh/CardBackMesh
@onready var card_front: MeshInstance3D = $CardMesh/CardFrontMesh


func initialize(carta : Carta) -> void:
	_data = carta

func _ready() -> void:
	if not _data:
		return
	card_back.set_surface_override_material(0, _data.back_material)
	card_front.set_surface_override_material(0, _data.front_material)
	
func get_rango() -> Carta.Rango:
	return _data.rango
	
func get_palo() -> Carta.Palo:
	return _data.palo
