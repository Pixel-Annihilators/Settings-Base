
extends Node

const keymaps_path := "user://keymaps.dat"
var keymaps: Dictionary

const settings_path := "user://settings.json"
var settings: Dictionary = {
	"master_volume": 0.442,
	"music_volume": 0.442,
	"sfx_volume": 0.442,
	"ball_speed_multiplier": 1.0
}

func _ready() -> void:
	# First we create the keymap dictionary on startup with all
	# the keymap actions we have.
	for action in InputMap.get_actions():
		if not InputMap.action_get_events(action).is_empty():
			keymaps[action] = InputMap.action_get_events(action)[0]

	load_keymap()
	load_settings()
	


func load_keymap() -> void:
	if not FileAccess.file_exists(keymaps_path):
		# There is no save file yet, so let's create one.
		save_keymap()
		return

	var file := FileAccess.open(keymaps_path, FileAccess.READ)
	var temp_keymap: Dictionary = file.get_var(true)
	file.close()
	# We don't just replace the keymaps dictionary, because if you
	# updated your game and removed/added keymaps, the data of this
	# save file may have invalid actions. So we check one by one to
	# make sure that the keymap dictionary really has all current actions.
	for action: StringName in keymaps.keys():
		if temp_keymap.has(action):
			keymaps[action] = temp_keymap[action]
			# Whilst setting the keymap dictionary, we also set the
			# correct InputMap event.
			InputMap.action_erase_events(action)
			InputMap.action_add_event(action, keymaps[action])
			print(action, keymaps[action])


func save_keymap() -> void:
	# For saving the keymap, we just save the entire dictionary as a var.
	var file := FileAccess.open(keymaps_path, FileAccess.WRITE)
	file.store_var(keymaps, true)
	file.close()

func save_settings() -> void:
	# no matter what, overwrite/write `settings` to `settings_path`
	var fh := FileAccess.open(settings_path, FileAccess.WRITE)
	fh.store_string(JSON.stringify(settings))
	fh.close()


func load_settings() -> void:
	# save if file doesn't exist
	if not FileAccess.file_exists(settings_path):
		save_settings()
		return
	
	var fh := FileAccess.open(settings_path, FileAccess.READ)
	var temp_settings : Dictionary = JSON.parse_string(fh.get_as_text())
	fh.close()
	
	for i in temp_settings:
		settings[i] = temp_settings[i]
	

	
	
	
