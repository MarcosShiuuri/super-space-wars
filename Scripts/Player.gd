extends KinematicBody2D

const bulletObj = preload("res://Scenes/pBullet.tscn")
const particleObj = preload("res://Scenes/Particles.tscn")
onready var main = get_parent()
var life = 20
var speed = 400 #400,500,600
var rotSpeed = 5
var vel = Vector2.ZERO
var rot = 0
var shooters = 1
var shieldTime = 6
var isdefending = false
var isPlayingSound = false

func _process(_delta):
	if shooters == 1:
		$S1sprite.visible = true
		$S2sprite.visible = false
		$S3sprite.visible = false
	if shooters == 2:
		$S1sprite.visible = false
		$S2sprite.visible = true
		$S3sprite.visible = true
	if shooters == 3:
		$S1sprite.visible = true
		$S2sprite.visible = true
		$S3sprite.visible = true

func _physics_process(delta):
	if main.isPaused == false:
		vel = Vector2.ZERO
		rot = 0
		
		if life <= 0:
			if isPlayingSound == false:
				main.get_node("Music").stop()
				$GameOverSound.play()
				isPlayingSound = true
			main.get_node("Canvas/UI/LifeSprite").visible = false
			main.get_node("Canvas/UI/ScoreSprite").visible = false
			main.get_node("Canvas/UI/GameOverPanel").visible = true
			main.get_node("Canvas/UI/GameOverPanel/RetryButton").grab_focus()
			var particle = particleObj.instance()
			main.add_child(particle)
			particle.global_position = self.global_position
			self.visible = false
			main.isPaused = true
		if life > 50:
			life = 50
		
		if isdefending == true:
			$ShieldArea.visible = true
			$ShieldArea/ShieldCol.disabled = false
			shieldTime -= 1 * delta
			if shieldTime <= 0:
				$ShieldArea.visible = false
				$ShieldArea/ShieldCol.disabled = true
				isdefending = false
				shieldTime = 6
		else:
			$ShieldArea.visible = false
			$ShieldArea/ShieldCol.disabled = true
		
		shootInput()
		moveInput()
		rotation += rot * rotSpeed * delta
		vel = move_and_slide(vel)
	
func moveInput():
	if Input.is_action_pressed("ui_up"):
		$Particle1.emitting = true
		$Particle2.emitting = true
		vel = Vector2(speed,0).rotated(rotation)
	elif Input.is_action_pressed("ui_down"):
		vel = Vector2(-speed,0).rotated(rotation)
		$Particle1.emitting = true
		$Particle2.emitting = true
	else:
		vel = Vector2.ZERO
		$Particle1.emitting = false
		$Particle2.emitting = false
	
	if Input.is_action_pressed("ui_right"):
		rot += 1
	elif Input.is_action_pressed("ui_left"):
		rot -= 1
	else:
		rot = 0

func shootInput():
	if Input.is_action_just_pressed("ui_atk"):
		$ShootSound.play()
		if shooters == 1 || shooters == 3:
			var bullet1 = bulletObj.instance()
			main.add_child(bullet1)
			bullet1.position = $Shooter1.global_position
			bullet1.rotation = $Shooter1.global_rotation
		if shooters == 2 || shooters == 3:
			var bullet2 = bulletObj.instance()
			main.add_child(bullet2)
			bullet2.position = $Shooter2.global_position
			bullet2.rotation = $Shooter2.global_rotation
			var bullet3 = bulletObj.instance()
			main.add_child(bullet3)
			bullet3.position = $Shooter3.global_position
			bullet3.rotation = $Shooter3.global_rotation
