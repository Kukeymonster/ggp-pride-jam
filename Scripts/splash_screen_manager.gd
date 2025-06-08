extends Control

@export var in_time: float = 0.5
@export var fade_in_time: float = 1.5
@export var pause_time: float = 1.5
@export var fade_out_time: float = 1.5
@export var out_time: float = 0.5
@export var Team_Logo: TextureRect
@export var Godot_Logo: TextureRect

func  _ready() -> void:
	fade()

func fade() -> void:
	Team_Logo.modulate.a = 0.0
	Godot_Logo.modulate.a = 0.0
	
	var Ttween = self.create_tween()
	Ttween.tween_interval(in_time)
	Ttween.tween_property(Team_Logo, "modulate:a", 1.0, fade_in_time)
	Ttween.tween_interval(pause_time)
	Ttween.tween_property(Team_Logo, "modulate:a", 0.0, fade_out_time)
	Ttween.tween_interval(out_time)
	await  Ttween.finished
	
	var tween = self.create_tween()
	tween.tween_interval(in_time)
	tween.tween_property(Godot_Logo, "modulate:a", 1.0, fade_in_time)
	tween.tween_interval(pause_time)
	tween.tween_property(Godot_Logo, "modulate:a", 0.0, fade_out_time)
	tween.tween_interval(out_time)
	await  tween.finished
	
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

func _input(event):
	#if the player is active in the sceen and the user presses ESC key toggle to mainmenu
	if (event.is_action_pressed(GlobalVars.INPUT_PAUSE) and is_visible_in_tree()):
		var currentTweens = get_tree().get_processed_tweens()
		for i in currentTweens:
			i.kill()
		
		get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
