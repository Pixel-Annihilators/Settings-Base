extends Control

@onready var MainMenuMarginContainer: MarginContainer = $MarginContainer
@onready var CreditsScene: Control = $CreditsScene
@onready var SettingsScene: Control = $SettingsScene


func _on_credits_button_pressed() -> void:
	MainMenuMarginContainer.visible = false
	CreditsScene.visible = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_settings_button_pressed() -> void:
	MainMenuMarginContainer.visible = false
	SettingsScene.visible = true
