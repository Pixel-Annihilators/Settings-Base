extends HBoxContainer

@onready var SFXVolumeHSlider: HSlider = $SFXVolumeHSlider
@onready var SFXVolumeValue: Label = $SFXVolumeValue


@onready var bus_index : int = AudioServer.get_bus_index("SFX")


func _ready() -> void:
	SFXVolumeHSlider.value = SettingsSaveManager.settings["sfx_volume"]


func _on_minus_button_pressed() -> void:
	SFXVolumeHSlider.value -= 0.001


func _on_plus_button_pressed() -> void:
	SFXVolumeHSlider.value += 0.001


func _on_sfx_volume_h_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))
	SFXVolumeValue.text = str(value*100)
	
	# save the value
	SettingsSaveManager.settings["sfx_volume"] = value
	SettingsSaveManager.save_settings()
