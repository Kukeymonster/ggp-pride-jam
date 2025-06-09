extends Node

#sets the user data path to be the project name
var UserDataLocation: String = "user://%s/user_prefs.tres" % ProjectSettings.get_setting("application/config/name")

#options menu
var Mastervolume: float
var Gamevolume: float
var Musicvolume: float
var SFXvolume: float
var Voicevolume: float

const windowModeArray: Array[String] = [
	"Full-Screen",
	"Window Mode",
	"Borderless Window",
	"Borderless Full-Screen"
	]

const resolutionDictionary: Dictionary = {
	"800 x 600"  : Vector2i( 800, 600),
	"1152 x 648" : Vector2i(1152, 648),
	"1280 x 720" : Vector2i(1280, 720),
	"1024 x 768" : Vector2i(1024, 768),
	"1366 x 768" : Vector2i(1366, 768),
	"1280 x 800" : Vector2i(1280, 800),
	"1400 x 900" : Vector2i(1400, 900),
	"1600 x 900" : Vector2i(1600, 900),
	"1280 x 1024": Vector2i(1280,1024),
	"1680 x 1050": Vector2i(1680,1050),
	"1920 x 1080": Vector2i(1920,1080),
	"2560 x 1440": Vector2i(2560,1440)
	}

#Animations
const ANIM_IDLE: String = "Idle"
const ANIM_MOVE: String = "Move"
const ANIM_DASH: String = "Dash"
const ANIM_ATTACK: String = "Attack"
const ANIM_DEATH: String = "Death"

#Inputs
const INPUT_DEBUG: String = "DEBUG"
const INPUT_MOVE_LEFT: String = "MoveLeft"
const INPUT_MOVE_RIGHT: String = "MoveRight"
const INPUT_MOVE_FORWARD: String = "MoveForward"
const INPUT_MOVE_BACKWARD: String = "MoveBackward"
const INPUT_JUMP: String = "Jump"
const INPUT_DASH: String = "Dash"
const INPUT_PAUSE: String = "Pause"
const INPUT_INTERACT: String = "Interact"

#notifcations
const NOTIFICATION_ENTER_STATE: int = 5001
const NOTIFICATION_EXIT_STATE: int = 5002

#Collision Layers & Masks
const C_LAYER_ENVIROMENT: int = 1
const C_LAYER_PLAYER: int = 2
const C_LAYER_ENEMY: int = 3
const C_MASK_ENVIROMENT: int = 1
const C_MASK_PLAYER: int = 2
const C_MASK_ENEMY: int = 3
