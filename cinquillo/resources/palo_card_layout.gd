class_name PaloCardLayout
extends CardLayout

# moves cards to where they belong in space
func update_card_positions(cards: Array[Card3D], duration: float):
	for i in range(cards.size()):
		var card = cards[i]
		if card is Carta3D:
			card.animate_to_position(calculate_card_position(card), duration)
			card.dragging_rotation(Vector3.ZERO)

func update_card_position(card: Card3D, _num_cards: int, _index: int, duration: float):
	card.animate_to_position(calculate_card_position(card), duration)
	card.dragging_rotation(Vector3.ZERO)

func calculate_card_position(card: Carta3D) -> Vector3:
	var y : float = float(int(card.get_rango())-5)
	var z: float = 0.06 - abs(y)/100.0
	return Vector3(0., y, z)


func calculate_card_position_by_index(_num_cards: int, _index: int) -> Vector3:
	return Vector3.ZERO


func calculate_card_rotations(num_cards: int) -> Array[Vector3]:
	var rotations: Array[Vector3] = []
	for i in range(num_cards):
		rotations.append(calculate_card_rotation_by_index(num_cards, i))
		
	return rotations


func calculate_card_rotation_by_index(_num_cards: int, _index: int) -> Vector3:
	return Vector3.ZERO
