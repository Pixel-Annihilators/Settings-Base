extends Button

@export var action := "up"

func _ready() -> void:
	assert(InputMap.has_action(action))
	set_process_unhandled_key_input(false)
	display_current_key()

func display_current_key() -> void:
	var current_key := InputMap.action_get_events(action)[0].as_text()
	text = current_key


func _toggled(is_button_pressed: bool) -> void:
	var SettingsBackButton:Button = get_tree().get_first_node_in_group("settings_back_button");
	set_process_unhandled_key_input(is_button_pressed)
	if is_button_pressed:
		# disable every other button on screen
		for i:Button in get_tree().get_nodes_in_group("keybind_buttons"):
			if i.action!=action:
				i.disabled = true
		SettingsBackButton.disabled = true;

		text = "<press a key>"
		modulate = Color.YELLOW
		release_focus()
	else:
		# enable every other button on screen
		for i:Button in get_tree().get_nodes_in_group("keybind_buttons"):
			if i.action!=action:
				i.disabled = false
		SettingsBackButton.disabled = false;

		display_current_key()
		modulate = Color.WHITE

		grab_focus()


func _unhandled_key_input(event: InputEvent) -> void:
	if event is InputEventKey and event.keycode != KEY_ENTER:
		remap_action_to(event)
		button_pressed = false

func remap_action_to(event: InputEvent) -> void:
	InputMap.action_erase_events(action)
	InputMap.action_add_event(action, event)
	SettingsSaveManager.keymaps[action] = event
	SettingsSaveManager.save_keymap()
	text = event.as_text()
