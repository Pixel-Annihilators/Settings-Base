extends HBoxContainer

@onready var MasterVolumeHSlider: HSlider = $MasterVolumeHSlider
@onready var MasterVolumeValue: Label = $MasterVolumeValue

@onready var bus_index : int = AudioServer.get_bus_index("Master")


func _ready() -> void:
	MasterVolumeHSlider.value = SettingsSaveManager.settings["master_volume"]


func _on_master_volume_h_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))
	MasterVolumeValue.text = str(value*100)
	
	# save the value
	SettingsSaveManager.settings["master_volume"] = value
	SettingsSaveManager.save_settings()


func _on_plus_button_pressed() -> void:
	MasterVolumeHSlider.value += 0.001


func _on_minus_button_pressed() -> void:
	MasterVolumeHSlider.value -= 0.001
