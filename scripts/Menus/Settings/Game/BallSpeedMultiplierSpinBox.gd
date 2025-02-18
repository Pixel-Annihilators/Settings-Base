extends SpinBox


func _ready() -> void:
	value = SettingsSaveManager.settings["ball_speed_multiplier"]

func _value_changed(new_value: float) -> void:
	SettingsSaveManager.settings["ball_speed_multiplier"] = new_value
