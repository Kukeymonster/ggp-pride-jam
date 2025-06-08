extends Control

@onready var vbox_container = $CenterContainer/Control/VBoxContainer
@export var creditsOffset = 10

func _ready():
	vbox_container.global_position.y = get_viewport_rect().size.y + creditsOffset

	var target_y = -vbox_container.size.y - creditsOffset

	var tween = create_tween()
	tween.tween_property(vbox_container, "global_position", Vector2(vbox_container.global_position.x, target_y), 30.0)
	tween.connect("finished", on_tween_finished)

func on_tween_finished():
	queue_free()

func _on_leave_button_pressed():
	queue_free()
