extends CardCollection3D

var accepted_upper_card: int = 5
var accepted_lower_card: int = 5
var palo = null

func append_card(card: Card3D)-> void:
	if card is Carta3D:
		if not palo:
			palo = card.get_palo()
		if accepted_lower_card == card.get_rango():
			accepted_lower_card -= 1
		if accepted_upper_card == card.get_rango():
			accepted_upper_card += 1
		card.hover_scale_factor =1.
		card.hover_pos_move = Vector3.ZERO
		insert_card(card, cards.size())

# whether or not a card can be selected
func can_select_card(_card) -> bool:
	return false


func can_remove_card(_card) -> bool:
	return false


func can_reorder_card(_card) -> bool:
	return false

# if the card can be inserted to the collection
func can_insert_card(_card: Carta3D, _from_collection) -> bool:
	print_debug(_card.get_palo())
	if not palo:
		if _card.get_rango() == Carta.Rango.CINCO:
			return true
	elif palo == int(_card.get_palo()):
		if accepted_lower_card == int(_card.get_rango()):
			return true
		elif accepted_upper_card == int(_card.get_rango()):
			return true
	return false
