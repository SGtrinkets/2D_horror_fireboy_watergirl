extends CharacterBody2D


const SPEED : float = 300.0
const JUMP_VELOCITY : float = -400.0
var push_force : float = 80.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("arrow_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("arrow_left", "arrow_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	for i in get_slide_collision_count():
		var slide = get_slide_collision(i)
		if slide.get_collider() is RigidBody2D:
			slide.get_collider().apply_central_impulse(-slide.get_normal() * push_force)
