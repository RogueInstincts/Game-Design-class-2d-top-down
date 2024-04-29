extends Node2D

@onready var main = $"."
@onready var button = $Panel/Button

func _process(_delta):
	if button.button_pressed:
		main.get_tree().change_scene_to_file("res://world.tscn")
