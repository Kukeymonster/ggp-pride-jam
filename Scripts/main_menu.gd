extends Control

var myGame
var myOptions = preload("res://Scenes/options_ui.tscn")
var myCredits = preload("res://Scenes/credits_ui.tscn")


func _on_play_button_pressed():
	get_tree().change_scene_to_file(myGame)

func _on_options_button_pressed():
	var subscene_instance = myOptions.instantiate()
	add_child(subscene_instance)

func _on_credits_button_pressed():
	var subscene_instance = myCredits.instantiate()
	add_child(subscene_instance)

func _on_exit_button_pressed():
	get_tree().quit()
