extends Node2D

@onready var world = $"."
@onready var health = 6
@onready var healthbar = $Camera/hud/healthbar

func _process(_delta):
	if health == 0:
		world.get_tree().change_scene_to_file("res://game_over.tscn")
	elif health == 1:
		healthbar.texture = load("res://1_health.png")
	elif health == 2:
		healthbar.texture = load("res://2_health.png")
	elif health == 3:
		healthbar.texture = load("res://3_health.png")
	elif health == 4:
		healthbar.texture = load("res://4_health.png")
	elif health == 5:
		healthbar.texture = load("res://5_health.png")
	elif health == 6:
		healthbar.texture = load("res://6_health.png")
