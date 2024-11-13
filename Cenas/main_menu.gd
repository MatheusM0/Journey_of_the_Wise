extends CanvasLayer



func _on_play_pressed() -> void:
	GameManager.start_game()
	queue_free()


func _on_exit_pressed() -> void:
	GameManager.exit_game()
