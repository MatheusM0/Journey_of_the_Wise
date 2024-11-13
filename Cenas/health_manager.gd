extends Node

var max_health : int = 3
var current_health : int

signal on_health_changed

func _ready() -> void:
	current_health = max_health
	

func decrease_health(health_amount : int):
	current_health -= health_amount
	
	if current_health < 0:
		current_health = 0
	
	
	on_health_changed.emit(current_health)
	print("morreno")