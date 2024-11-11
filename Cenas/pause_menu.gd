extends Control

@export var game_manager : Fase1

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	#game_manager.connect("toggle_game_paused", _on_fase_1_toggle_game_paused)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_fase_1_toggle_game_paused(is_paused : bool):
	if(is_paused):
		show()
	else:
		hide()
