extends Control

func _ready() -> void:
	$MarginContainer/VBoxContainer/Start.pressed.connect(on_start)
	$MarginContainer/VBoxContainer/Options.pressed.connect(on_options)
	$MarginContainer/VBoxContainer/Exit.pressed.connect(on_exit)
	$Panel/VBoxContainer/GridContainer/CheckButton.toggled.connect(on_full_screen)
	$Panel/CloseButton.pressed.connect(on_close_options)
	if OS.get_name() == "HTML5":
		$MarginContainer/VBoxContainer/Exit.disabled = true
	
func on_start() -> void:
	$"..".hide()
	$"../AnimationPlayer".play("RESET")
	hide()
	pass

func on_options() -> void:
	$Panel.show()
	pass

func on_close_options() -> void:
	$Panel.hide()
	pass

func on_full_screen(full_screen : bool) -> void:
	if full_screen:
		print_debug('full screen')
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		return
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	print_debug('window')

func on_exit() -> void:
	get_tree().quit()
