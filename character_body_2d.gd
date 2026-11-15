extends CharacterBody2D

@export var rigid_body_2d: RigidBody2D
@export var game_over_screen: Control

const SPEED = 350.0
const JUMP_VELOCITY = -600.0
const Knockback_strength = 5000

func _physics_process(delta: float) -> void:
	# Add the gravity. Gravity is negative so velocity is decrasing -> 
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	#if Input.is_action_just_pressed("Jump") and is_on_floor():
		#velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_on_floor():
		velocity.y = JUMP_VELOCITY
	if Input.is_action_just_pressed("Restart"):
		get_tree().reload_current_scene()
	
func _on_bounce_box_body_entered(body: Node2D) -> void:
	print("I will bounce you off")
	velocity.y -= Knockback_strength
	
func _on_playable_area_body_exited(body: Node2D) -> void:
	print("You fell out of bounds")
	#Play death screen
	game_over_screen.visible = true
