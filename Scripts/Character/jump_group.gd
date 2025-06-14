extends Node3D

# Bounce parameters
@export var min_bounce_height: float = 0.2
@export var max_bounce_height: float = 0.6

@export var min_bounce_duration: float = 0.8
@export var max_bounce_duration: float = 1.5

@export var bounce_delay_range: float = 0.5

func _ready():
	for child in get_children():
		if child is Sprite3D:
			_start_bounce(child)

func _start_bounce(sprite: Sprite3D):
	var tween := create_tween()
	tween.set_loops()  # Loop forever

	var base_position := sprite.position
	var height := randf_range(min_bounce_height, max_bounce_height)
	var duration := randf_range(min_bounce_duration, max_bounce_duration)
	var delay := randf_range(0.0, bounce_delay_range)

	tween.tween_property(sprite, "position:y", base_position.y + height, duration).set_delay(delay).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(sprite, "position:y", base_position.y, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
