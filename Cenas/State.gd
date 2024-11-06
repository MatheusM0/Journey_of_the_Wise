extends Node

class_name State

@export var can_move : bool = true
var character : CharacterBody2D
var playback : AnimationNodeStateMachinePlayback
var next_state : State

signal interrupt_state(new_state : State)

func state_process(delta):
	pass

func state_input(event : InputEvent):
	pass


func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func on_enter():
	pass
	
func on_exit():
	pass
