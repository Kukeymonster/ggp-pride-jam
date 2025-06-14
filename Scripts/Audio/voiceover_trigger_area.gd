extends Area3D

@export var voiceover_audio: AudioStream
@export var audio_stream_player: AudioStreamPlayer

func _on_body_entered(_body: Node3D) -> void:
	audio_stream_player.stream = voiceover_audio
	call_deferred("_kill_me_now")
	audio_stream_player.play()

func _kill_me_now() -> void:
	get_child(0).process_mode = Node.PROCESS_MODE_DISABLED
	process_mode = Node.PROCESS_MODE_DISABLED
