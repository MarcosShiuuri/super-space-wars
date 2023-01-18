extends Node2D

var isPaused = false
var isRetrying = false
var isExiting = false
var canPause = true
var timerToReload = 2
var timerToPause = 0.3
var cbgTimer = 15
var cbgCount = 1
var textureRed = preload("res://Sprites/Backgrounds/Red.png")
var textureGreen = preload("res://Sprites/Backgrounds/Green.png")
var texturedBlue = preload("res://Sprites/Backgrounds/dBlue.png")
var texturelBlue = preload("res://Sprites/Backgrounds/lBlue.png")
var textureYellow = preload("res://Sprites/Backgrounds/Yellow.png")
var texturePink = preload("res://Sprites/Backgrounds/Pink.png")
var score = 0

func _physics_process(delta):
	$Canvas/UI/GameOverPanel/GoScoreText.text = str(score)
	$Canvas/UI/ScoreSprite/ScoreText.text = str(score)
	$Canvas/UI/LifeSprite/LifePogress.value = $Player.life
	
	if isRetrying == true:
		isPaused = true
		timerToReload -= 1 * delta
		if timerToReload <= 0:
			# warning-ignore:return_value_discarded
			get_tree().change_scene("res://Scenes/Main.tscn")
	if isExiting == true:
		isPaused = true
		timerToReload -= 1 * delta
		if timerToReload <= 0:
			# warning-ignore:return_value_discarded
			get_tree().change_scene("res://Scenes/TitleScreen.tscn")
	
	if timerToPause > 0:
		timerToPause -= 1 * delta
	else:
		timerToPause = 0
	
	if canPause == true:
		if Input.is_action_just_pressed("ui_pause") && timerToPause <=0:
			$Music.stream_paused = true
			isPaused = true
			$Canvas/UI/PausePanel/ResumeButton.grab_focus()
			$Canvas/UI/PausePanel.visible = true
	
	if isPaused == false:
		cbgTimer -= 1 * delta
		if cbgTimer <= 0:
			changeCBG()
		
func changeCBG():
	cbgTimer = 15
	if cbgCount == 1:
		$Canvas/ColorBackground.texture = textureRed
		cbgCount += 1
		return
	if cbgCount == 2:
		$Canvas/ColorBackground.texture = textureYellow
		cbgCount += 1
		return
	if cbgCount == 3:
		$Canvas/ColorBackground.texture = texturedBlue
		cbgCount += 1
		return
	if cbgCount == 4:
		$Canvas/ColorBackground.texture = texturePink
		cbgCount += 1
		return
	if cbgCount == 5:
		$Canvas/ColorBackground.texture = texturelBlue
		cbgCount += 1
		return
	if cbgCount == 6:
		$Canvas/ColorBackground.texture = textureGreen
		cbgCount = 1
		return


func _on_RetryButton_button_down():
	$Music.stop()
	$Select.play()
	canPause = false
	$Canvas/UI/GameOverPanel/RetryButton.release_focus()
	$Canvas/UI/GameOverPanel.visible = false
	self.visible = false
	isRetrying = true


func _on_GoExitButton_button_down():
	$Music.stop()
	$Select.play()
	canPause = false
	$Canvas/UI/GameOverPanel.visible = false
	$Canvas/UI/GameOverPanel/GoExitButton.release_focus()
	self.visible = false
	isExiting = true


func _on_ResumeButton_button_down():
	$Music.stream_paused = false
	$Select.play()
	timerToPause = 0.3
	$Canvas/UI/PausePanel/ResumeButton.release_focus()
	isPaused = false
	$Canvas/UI/PausePanel.visible = false


func _on_PEButton_button_down():
	$Music.stop()
	$Select.play()
	canPause = false
	timerToPause = 0.3
	$Canvas/UI/PausePanel.visible = false
	$Canvas/UI/PausePanel/PEButton.release_focus()
	self.visible = false
	isExiting = true
