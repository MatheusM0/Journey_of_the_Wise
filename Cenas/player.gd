extends CharacterBody2D

class_name Player

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var hit_animation_player: AnimationPlayer = $HitAnimationPlayer
var player_death = preload("res://Cenas/player_death.tscn")
@export var speed = 100.0
@export var jump_velocity : float = -350
@onready var sprite2D : Sprite2D = $Sprite2D
@onready var animation_tree : AnimationTree = $AnimationTree
@onready var state_machine : CharacterStateMachine = $CharacterStateMachine
var direction : Vector2 = Vector2.ZERO

signal facing_direction_changed(facing_right : bool)

func _onready():
	animation_tree.active = true
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("Pula") and is_on_floor():
		velocity.y = jump_velocity

	if Input.is_action_just_released("Pula") and velocity.y < 0:
		velocity.y *= 0.5
	
	direction = Input.get_vector("Atrás", "Frente", "Pula", "Baixo")
	
	if direction.x != 0 && state_machine.check_in_can_move():
		velocity.x = direction.x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
	move_and_slide()
	update_animation()
	update_facing_direction()

func update_animation():
	animation_tree.set("parameters/move/blend_position", direction.x )
	
func update_facing_direction():
	if direction.x > 0:
		sprite2D.flip_h = false
	elif direction.x < 0:
		sprite2D.flip_h = true
		
	emit_signal("facing_direction_changed", !sprite2D.flip_h)

func player_death_func():
	var player_death_instance = player_death.instantiate() 
	player_death_instance.global_position = global_position
	get_parent().add_child(player_death_instance)
	queue_free()

func _on_hurtbox_body_entered(body: Node2D):
	if body.is_in_group("Enemy"):
		hit_animation_player.play("hit")
		#print("AIAIIII", body.damage_amount)
		HealthManager.decrease_health(body.damage_amount)
		
	if HealthManager.current_health == 0:
		player_death_func()


func _on_area_2d_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
