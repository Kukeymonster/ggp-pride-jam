extends Control

@export var myGame: PackedScene
var myOptions = preload("res://Scenes/options_ui.tscn")
var myCredits = preload("res://Scenes/credits_ui.tscn")
@export var FadeInPanel: TextureRect
var in_time: float = 0.5
var fade_in_time: float = 0.5

func _ready():
	FadeInPanel.visible = true
	FadeInPanel.modulate.a = 1.0
	
	var Ftween = self.create_tween()
	Ftween.tween_interval(in_time)
	Ftween.tween_property(FadeInPanel, "modulate:a", 0.0, fade_in_time)
	await  Ftween.finished
	FadeInPanel.visible = false


func _on_play_button_pressed():
	get_tree().change_scene_to_packed(myGame)

func _on_options_button_pressed():
	var subscene_instance = myOptions.instantiate()
	add_child(subscene_instance)

func _on_credits_button_pressed():
	var subscene_instance = myCredits.instantiate()
	add_child(subscene_instance)

func _on_exit_button_pressed():
	get_tree().quit()
