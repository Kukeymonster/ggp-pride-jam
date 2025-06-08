extends Resource
class_name UserPreferences

@export_range(0,1,0.05) var masterAudioLevel: float = 1.0
@export_range(0,1,0.05) var musicAudioLevel: float = 1.0
@export_range(0,1,0.05) var sfxAudioLevel: float = 1.0
@export var windowModeIndex: int = 0
@export var resolutionIndex: int = 10

@export var actionEvents: Dictionary = {}

func save() -> void:
	#get project name
	var project_name = ProjectSettings.get_setting("application/config/name")
	#Check the users data location
	var dir = DirAccess.open("user://")
	#create a directory if one does not exsit
	if dir != null and !dir.dir_exists(project_name):
		dir.make_dir(project_name)
	
	#save the resource or push a error that it cant
	var error = ResourceSaver.save(self, GlobalVars.UserDataLocation)
	if error != OK:
		push_error("Failed to save user preferences: %s" % error)

#loads the preferences or creates it
static func loadOrCreate() -> UserPreferences:
	if ResourceLoader.exists(GlobalVars.UserDataLocation):
		var res: UserPreferences = load(GlobalVars.UserDataLocation) as UserPreferences
		if res != null:
			return res

	# File doesn't exist or failed to load — create new preferences
	var new_prefs = UserPreferences.new()
	# Save immediately so the file exists next time
	new_prefs.save() 
	return new_prefs
