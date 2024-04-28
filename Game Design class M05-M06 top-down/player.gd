extends CharacterBody2D

@onready var world = $".."
@onready var damage_timer = 0
@onready var sword_timer = 0
@onready var facing = Vector2(1,0)
@onready var sword

const SPEED = 300.0

func sword_hit(i):
	pass

func enemy_sword_hit(i):
	damage()
	i.queue_free()

func damage():
	if damage_timer <= 0:
		world.health -= 1
		damage_timer = 50

func _physics_process(_delta):
	
	if Input.is_action_just_pressed("attack") and sword_timer <= 0:
		sword = load("res://sword.tscn").instantiate()
		var t = Transform2D()
		t.origin = Vector2(25,0)
		var rot = deg_to_rad(90)
		t.x.x = cos(rot)
		t.y.y = cos(rot)
		t.x.y = sin(rot)
		t.y.x = -sin(rot)
		sword.transform = t
		add_child(sword)
		sword_timer = 20
	
	if damage_timer > 0:
		damage_timer -= 1
	
	if sword_timer > 0:
		sword_timer -= 1
	
	if sword_timer == 10:
		if $sword:
			$sword.queue_free()
		if world.health == 6:
			sword = load("res://sword.tscn").instantiate()
			var t = Transform2D()
			t.origin = Vector2(transform.origin.x, transform.origin.y)
			sword.transform = t
			sword.direction = facing
			world.add_child(sword)
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Vector2(0,0)
	if Input.is_action_pressed("up"):
		direction.y = -1
		facing = direction
	elif Input.is_action_pressed("down"):
		direction.y = 1
		facing = direction
	elif Input.is_action_pressed("left"):
		direction.x = -1
		facing = direction
	elif Input.is_action_pressed("right"):
		direction.x = 1
		facing = direction
	
	if direction:
		velocity = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	if velocity.y < 0:
		rotation = deg_to_rad(-90)
	elif velocity.y > 0:
		rotation = deg_to_rad(90)
	elif velocity.x < 0:
		rotation = deg_to_rad(180)
	elif velocity.x > 0:
		rotation = deg_to_rad(0)

	move_and_slide()
