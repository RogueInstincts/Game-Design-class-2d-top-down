extends Area2D

@onready var player = $"../../player"
@onready var camera = $"../../Camera"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	for i in get_overlapping_bodies():
		if i == player:
			camera.transform.origin = Vector2(576, 324)
			player.transform.origin = Vector2(800, 400)
