class_name player
extends CharacterBody2D

const SPEED : float = 200.0
const JUMP_VELOCITY : float = -400.0
var push_force : float = 50.0

	
func collision_detect():
	for i in get_slide_collision_count():
		var slide = get_slide_collision(i)
		if slide.get_collider() is RigidBody2D:
			slide.get_collider().apply_central_impulse(-slide.get_normal() * push_force)
