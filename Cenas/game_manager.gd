extends Node
var menu_screen = preload("res://Cenas/main_menu.tscn")
var fase_1 = preload("res://Cenas/fase_1.tscn")
var pause_screen  = preload("res://Cenas/pause_menu.tscn")

func _ready() -> void:
	pass # Replace with function body.

func start_game():
	if get_tree().paused:
		continue_game()
		return
	
	transition_to_game(fase_1.resource_path)

func exit_game():
	get_tree().quit()

func transition_to_game(scene_path):  # Removi o espaço extra antes de 'func'
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file(scene_path)

func pause_game():
	get_tree().paused =  true
	var pause_screen_APARECEAI = pause_screen.instantiate()
	get_tree().get_root().add_child(pause_screen_APARECEAI)
	
func continue_game():
	get_tree().paused = false

func main_menu():
	var main_screen__ = menu_screen.instantiate()
	get_tree().get_root().add_child(main_screen__)
