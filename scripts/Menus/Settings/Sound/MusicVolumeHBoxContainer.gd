extends HBoxContainer

@onready var MusicVolumeHSlider: HSlider = $MusicVolumeHSlider
@onready var MusicVolumeValue: Label = $MusicVolumeValue

@onready var bus_index : int = AudioServer.get_bus_index("Music")

func _ready() -> void:
	MusicVolumeHSlider.value = SettingsSaveManager.settings["music_volume"]

func _on_plus_button_pressed() -> void:
	MusicVolumeHSlider.value += 0.001


func _on_minus_button_pressed() -> void:
	MusicVolumeHSlider.value -= 0.001


func _on_music_volume_h_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))
	MusicVolumeValue.text = str(value*100)

	# save the value
	SettingsSaveManager.settings["music_volume"] = value
	SettingsSaveManager.save_settings()
