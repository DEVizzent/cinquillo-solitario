extends CardCollection3D

const CARTA_MOVEMENT_DURATION = 3.0
const DELAY_BETWEEN_CARDS_DRAW = .1

@onready var hand: CardCollection3D = $"../DragController/Hand"
@onready var timer: Timer = $Timer

func _ready() -> void:
	card_clicked.connect(move_to_hand)
	
func move_to_hand(_card) -> void:
	var carta : Carta3D
	for i in range(5):
		carta = pop_card()
		hand.append_card(carta)
		carta.position = position
		timer.start()
		await timer.timeout


func can_select_card(_card) -> bool:
	return true

func can_remove_card(_card) -> bool:
	return true

func can_reorder_card(_card) -> bool:
	return true

func can_insert_card(_card, _from_collection) -> bool:
	return false
