extends Control

var timer = 2
var changeScene = false
const bcground1 = preload("res://Sprites/Backgrounds/Red.png")
const bcground2 = preload("res://Sprites/Backgrounds/dBlue.png")
const bcground3 = preload("res://Sprites/Backgrounds/Green.png")

func _ready():
	$Title/Buttons/StartButton.grab_focus()

func _physics_process(delta):
	if changeScene == true:
		timer -= 1 * delta
		if timer <= 0:
			# warning-ignore:return_value_discarded
			get_tree().change_scene("res://Scenes/Main.tscn")

func _on_StartButton_button_down():
	$Music.stop()
	$Select.play()
	$Title/Buttons/StartButton.release_focus()
	$Title.visible = false
	$ColorBackground.visible = false
	$Title/Buttons/StartButton.disabled = true
	$Title/Panels/ControlsPanel/ControlsExitButton.disabled = true
	$Title/Panels/CreditsPanel/CreditsExitButton.disabled = true
	changeScene = true

func _on_ControlsButton_button_down():
	$Select.play()
	$Title/Panels/ControlsPanel/ControlsExitButton.grab_focus()
	$ColorBackground.texture = bcground2
	$Title/Panels/ControlsPanel.visible = true
	$Title/Panels/ControlsPanel/ControlsExitButton.disabled = false

func _on_CreditsButton_button_down():
	$Select.play()
	$Title/Panels/CreditsPanel/CreditsExitButton.grab_focus()
	$ColorBackground.texture = bcground1
	$Title/Panels/CreditsPanel.visible = true
	$Title/Panels/CreditsPanel/CreditsExitButton.disabled = false

func _on_CreditsExitButton_button_down():
	$Select.play()
	$Title/Buttons/CreditsButton.grab_focus()
	$ColorBackground.texture = bcground3
	$Title/Panels/CreditsPanel.visible = false
	$Title/Panels/CreditsPanel/CreditsExitButton.disabled = true

func _on_ControlsExitButton_button_down():
	$Select.play()
	$Title/Buttons/ControlsButton.grab_focus()
	$ColorBackground.texture = bcground3
	$Title/Panels/ControlsPanel.visible = false
	$Title/Panels/ControlsPanel/ControlsExitButton.disabled = true
