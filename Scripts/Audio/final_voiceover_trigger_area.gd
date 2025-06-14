extends Area3D

@export var myPlayer: CharacterBody3D
@export var voiceover_audio: AudioStream
@export var audio_stream_player: AudioStreamPlayer3D

func _kill_me_now() -> void:
	get_child(0).process_mode = Node.PROCESS_MODE_DISABLED
	process_mode = Node.PROCESS_MODE_DISABLED

func _on_final_voiceover_playback_finished():
	await 1.5
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED

func _on_final_body_entered(body):
	body.set_process_input(false)
	audio_stream_player.stream = voiceover_audio
	call_deferred("_kill_me_now")
	audio_stream_player.play()
