extends CheckButton

@export var transitioner : Transitioner



func _on_toggled(toggled_on: bool) -> void:
	transitioner.set_next_animation(button_pressed)
