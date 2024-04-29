extends Sprite2D

@onready var hitbox = $hitbox
@onready var player = $'../player'
@onready var world = $".."

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for i in hitbox.get_overlapping_bodies():
		if i == player:
			queue_free()
			world.coin += 1
