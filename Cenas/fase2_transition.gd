extends Area2D
var FASE_2_COLOCAR = preload("res://Cenas/fase_2_colocar.tscn")

func _on_body_entered(body: Node2D) -> void:
	if (body is Player):
		GameManager.transition_to_game(FASE_2_COLOCAR.resource_path)
