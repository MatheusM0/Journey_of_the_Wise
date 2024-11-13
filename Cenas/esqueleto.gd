extends CharacterBody2D

@onready var animation_tree : AnimationTree = $AnimationTree
@export var patrol_points: Node
@onready var sprite_2d: Sprite2D = $Sprite2D

@export var direction : Vector2 = Vector2.LEFT
@export var movement_speed : float = 1500
@export var hit_state : State
@export var damage_amount : int = 1
@onready var state_machine : CharacterStateMachine = $CharacterStateMachine

var number_of_points : int
var point_positions : Array[Vector2]
var current_point : Vector2
var current_point_position : int

func _ready() -> void:
	animation_tree.active = true
	if patrol_points != null:
		number_of_points = patrol_points.get_children().size()
		for point in patrol_points.get_children():
			point_positions.append(point.global_position)
		current_point = point_positions[current_point_position]
	else:
		print("perdidinho")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if direction && state_machine.check_in_can_move():
		enemy_walk(delta)
	elif state_machine.current_state != hit_state:
		velocity.x = move_toward(velocity.x, 0, movement_speed)
	
	move_and_slide()

func enemy_walk(delta : float):
	if abs(position.x - current_point.x) > 0.5:
		velocity.x = direction.x * movement_speed * delta
	else:
		current_point_position += 1
	if current_point_position >= number_of_points:
		current_point_position = 0
	
	current_point = point_positions[current_point_position]
	
	if current_point.x > position.x:
		direction = Vector2.RIGHT
	else:
		direction = Vector2.LEFT
	sprite_2d.flip_h = direction.x > 0
