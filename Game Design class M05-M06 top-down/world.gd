extends Node2D

@onready var world = $"."
@onready var health = 6
@onready var coin = 0
@onready var healthbar = $Camera/hud/healthbar
@onready var coinlabel = $Camera/hud/coinlabel
@onready var kills_to_win = 12

func generate_loot(spot: Vector2):
	var loot = randi() % 5
	if loot == 1:
		var add = load("res://coin.tscn").instantiate()
		add.transform.origin = spot
		add_child(add)
	elif loot == 2:
		var add = load("res://heart.tscn").instantiate()
		add.transform.origin = spot
		add_child(add)

func _process(_delta):
	
	if kills_to_win <= 0:
		world.get_tree().change_scene_to_file("res://victory.tscn")
	
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
	elif health > 6:
		health = 6
	
	coinlabel.set_text("X " + str(coin))
