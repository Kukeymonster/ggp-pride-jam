extends CharacterBody3D

@export var mouse_sensitivity := 0.002
@export var move_speed := 3.0

@export var step_sound_distance_interval := .25
@export var pitch_variance := 0.04
@export var step_SFX: AudioStream

var _look_vertical := 0.0
var distance_since_SFX_played := 0.0
var rand_pitch_shift:= 1.0

@onready var head := $Head
@onready var sfx_player := $SFXPlayer

var myPauseMenu = preload("res://Scenes/pause_menu.tscn")
var subscene_instance: Node = null

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * mouse_sensitivity)
		_look_vertical = clamp(_look_vertical - event.relative.y * mouse_sensitivity, deg_to_rad(-89), deg_to_rad(89))
		head.rotation.x = _look_vertical
	elif event.is_action_pressed("ui_cancel"):
		if subscene_instance == null:
			match Input.mouse_mode:
				Input.MOUSE_MODE_CAPTURED:
					Input.mouse_mode = Input.MOUSE_MODE_CONFINED
					subscene_instance = myPauseMenu.instantiate()
					subscene_instance.closed.connect(_on_pause_menu_closed)
					add_child(subscene_instance)
				Input.MOUSE_MODE_CONFINED:
					Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
				_:
					Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		
		

func _physics_process(delta):
	var input_dir := Vector3.ZERO
	if Input.is_action_pressed(GlobalVars.INPUT_MOVE_FORWARD):
		input_dir -= transform.basis.z
	if Input.is_action_pressed(GlobalVars.INPUT_MOVE_BACKWARD):
		input_dir += transform.basis.z
	if Input.is_action_pressed(GlobalVars.INPUT_MOVE_LEFT):
		input_dir -= transform.basis.x
	if Input.is_action_pressed(GlobalVars.INPUT_MOVE_RIGHT):
		input_dir += transform.basis.x
	
	input_dir.y = 0
	input_dir = input_dir.normalized()
	
	velocity = input_dir * move_speed
	move_and_slide()
	
	distance_since_SFX_played += velocity.length() * get_process_delta_time()
	if(distance_since_SFX_played >= step_sound_distance_interval):
		_play_steppy()
	

func _on_pause_menu_closed():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	subscene_instance = null

func _play_steppy():
	distance_since_SFX_played = 0
	if(!sfx_player.stream):
		sfx_player.stream = step_SFX
	
	rand_pitch_shift = (1.0 + (pitch_variance / 2.0)) - (randf() * pitch_variance)
	sfx_player.pitch_scale = rand_pitch_shift
	
	sfx_player.play()
	
