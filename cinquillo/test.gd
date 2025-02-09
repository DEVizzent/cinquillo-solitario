extends Node3D

@export var baraja : Baraja
@export var carta_3d_scene : PackedScene = preload("res://cinquillo/carta_3d.tscn")
@onready var pila: CardCollection3D = $Pila
@onready var palo_1: CardCollection3D = $DragController/Palo1
@onready var palo_2: CardCollection3D = $DragController/Palo2
@onready var palo_3: CardCollection3D = $DragController/Palo3
@onready var palo_4: CardCollection3D = $DragController/Palo4


func _ready() -> void:
	palo_1.palo_completed.connect(check_game_completed)
	palo_2.palo_completed.connect(check_game_completed)
	palo_3.palo_completed.connect(check_game_completed)
	palo_4.palo_completed.connect(check_game_completed)
	prepare_game()
	
func prepare_game():
	if not baraja:
		push_error('Necesitamos baraja para jugar al cinquillo')
	var instancia_carta : Node3D
	for carta in baraja.cartas:
		instancia_carta = carta_3d_scene.instantiate()
		instancia_carta.initialize(carta)
		pila.append_card(instancia_carta)
	pila.cards.shuffle()

func check_game_completed() -> void:
	if palo_1.is_completed() and palo_2.is_completed() and palo_3.is_completed() and palo_4.is_completed():
		ending()

func ending() -> void:
	var timer = get_tree().create_timer(.2)
	timer.timeout.connect(ending_animation)

func ending_animation() -> void:
	var delay : float = 0.
	var tween : Tween = get_tree().create_tween()
	var end_position : Vector3 = $Camera3D.global_position + Vector3.BACK
	var end_rotation : Vector3 = Vector3(deg_to_rad(360), deg_to_rad(360), deg_to_rad(360))
	tween.set_parallel(true)
	tween.set_ease(Tween.EASE_IN)
	for card_number in range(10):
		move_end_carta(palo_1.cards[card_number], tween, end_position, end_rotation, delay)
		delay += .1
		move_end_carta(palo_2.cards[card_number], tween, end_position, end_rotation, delay)
		delay += .1
		move_end_carta(palo_3.cards[card_number], tween, end_position, end_rotation, delay)
		delay += .1
		move_end_carta(palo_4.cards[card_number], tween, end_position, end_rotation, delay)
		delay += .1
	var timer = get_tree().create_timer(4.)
	timer.timeout.connect($Intro.show())
	tween.finished.connect(restart_game)

func move_end_carta(carta: Card3D, tween: Tween, end_position: Vector3, end_rotation: Vector3, delay: float) -> void:
	tween.tween_property(carta, 'global_position', end_position, 1.0).set_delay(delay)
	tween.tween_property(carta, 'rotation', end_rotation, 1.0).set_delay(delay)

func restart_game() -> void:
	$Intro/AnimationPlayer.play("Intro")
	palo_1.remove_all()
	palo_2.remove_all()
	palo_3.remove_all()
	palo_4.remove_all()
	prepare_game()
	
