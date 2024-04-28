extends CharacterBody2D

var direction = Vector2(0, 0)
@onready var sword = $"."
@onready var hitbox = $hitbox

const SPEED = 300.0

func _physics_process(_delta):
	
	if direction:
		velocity = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	if direction.x == 1:
		look_at(transform.origin + Vector2(0,1))
	elif direction.x == -1:
		look_at(transform.origin + Vector2(0,-1))
	elif direction.y == 1:
		look_at(transform.origin + Vector2(-1,0))
	
	for i in hitbox.get_overlapping_bodies():
		i.enemy_sword_hit(sword)
	
	if is_on_wall() or is_on_ceiling() or is_on_floor():
		queue_free()

	move_and_slide()
