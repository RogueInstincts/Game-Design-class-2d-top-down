extends CharacterBody2D

@onready var hitbox = $hitbox
@onready var player = $"../../player"
@onready var move_timer = 0
@onready var direction = 0
@onready var sword
@onready var facing = Vector2(0,-1)
@onready var world = $"../.."

const SPEED = 100.0

func sword_hit(i):
	queue_free()
	i.queue_free()
	world.generate_loot(transform.origin)
	world.kills_to_win -= 1

func enemy_sword_hit(i):
	pass

func _physics_process(delta):
	# Get the direction and handle the movement/deceleration.
	if move_timer > 0:
		move_timer -= 1
	
	if is_on_wall():
		direction = (randi() % 4) + 1
	
	if move_timer <= 0:
		direction = randi() % 5
		move_timer = (randi() % 20) + 30
	
	if direction == 0:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
	elif direction == 1:
		velocity = Vector2(SPEED, 0)
		facing = Vector2(1, 0)
	elif direction == 2:
		velocity = Vector2(-SPEED, 0)
		facing = Vector2(-1, 0)
	elif direction == 3:
		velocity = Vector2(0, SPEED)
		facing = Vector2(0, 1)
	elif direction == 4:
		velocity = Vector2(0, -SPEED)
		facing = Vector2(0, -1)
	
	look_at(transform.origin + facing)
	
	for i in hitbox.get_overlapping_bodies():
		if i == player:
			i.damage(transform.origin)
	
	var makesword = randi() % 150
	if makesword == 1:
		sword = load("res://enemy_sword.tscn").instantiate()
		var t = Transform2D()
		t.origin = Vector2(transform.origin.x, transform.origin.y)
		sword.transform = t
		sword.direction = facing
		world.add_child(sword)

	move_and_slide()
