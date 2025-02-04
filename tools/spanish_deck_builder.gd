@tool
extends Node

const REGEX_CARD_FILE_NAME = "^\\d{2}\\-\\w*\\.png$"
const BARAJA_PATH = "res://cinquillo/resources/baraja.tres"
const BACK_CARD_MATERIAL = "res://cinquillo/resources/back_card_material.tres"

@export_tool_button("build_collection") var build_collection_call : Callable = build_collection
@export var card_collection : CardCollection3D
@export_dir var cards_img_folder_path : String

func _ready() -> void:
	pass

func build_collection() -> void:
	var baraja : Baraja = load(BARAJA_PATH)
	var back_material :StandardMaterial3D = load(BACK_CARD_MATERIAL)
	var carta : Carta 
	for palo in Carta.Palo:
		for rango in Carta.Rango:
			var front_material : StandardMaterial3D = back_material.duplicate(true)
			print("res://img/" + map_rango(rango) + "-" + map_palo(palo) + ".png")
			front_material.albedo_texture = load("res://img/" + map_rango(rango) + "-" + map_palo(palo) + ".png")
			#front_material.albedo_texture = load("res://img/" + map_rango(rango) + "-" + map_palo(palo) + ".png")
			carta = Carta.new()
			carta.initialize(Carta.Palo.get(palo), Carta.Rango.get(rango),front_material, back_material)
			baraja.cartas.append(carta)
	ResourceSaver.save(baraja, BARAJA_PATH)

func map_rango(rango: String) -> String:
	match rango:
		"AS":
			return "01"
		"DOS":
			return "02"
		"TRES":
			return "03"
		"CUATRO":
			return "04"
		"CINCO":
			return "05"
		"SEIS":
			return "06"
		"SIETE":
			return "07"
		"SOTA":
			return "10"
		"CABALLO":
			return "11"
		"REY":
			return "12"
		_:
			push_error('Invalid Rango')
			return "01"

func map_palo(palo:String) -> String:
	return palo.to_lower()

func find_card_imgs_in_path(path: String) -> Array[String]:
	var card_img_paths : Array[String] = []
	var card_file_name_regex_validator = RegEx.create_from_string(REGEX_CARD_FILE_NAME)
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				continue
			if card_file_name_regex_validator.search(file_name):
				card_img_paths.append(path + '/' + file_name)	
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
	return card_img_paths

func dir_contents(path) -> void:
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				print("Found directory: " + file_name)
			else:
				print("Found file: " + file_name)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
