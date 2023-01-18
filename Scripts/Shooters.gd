extends KinematicBody2D

const bulletObj = preload("res://Scenes/eBullet.tscn")
const bombObj = preload("res://Scenes/eBomb.tscn")
onready var main = get_parent()
onready var target = get_parent().get_node("Player")
onready var spawner = get_parent().get_node("Spawner")
export (int) var speed = 0 #Shooters: 350,250, #Bombers:  
export (int) var distanceTarget = 0 #Shooters: 500,450 #Bombers:
var shootTime = 0
export (float) var shootTimeMax = 0 #Shooters #2,1.8 #Bombers:
export (int) var shooterType = 1 #Shooters: 1,2,3,4 #Bombers: 5,6,7,8
var vel = Vector2.ZERO
export (int) var life

func _ready():
	shootTime = shootTimeMax

func _physics_process(delta):
	if main.isPaused == false:
		vel = Vector2.ZERO
		
		if life <= 0:
			$DestructSound.play()
			spawner.enemyCount -= 1
			main.score += 175
			queue_free()
		
		atkMode(delta)
		moveMode()
		vel = move_and_slide(vel)
	
func moveMode():
	look_at(target.global_position)
	if (target.global_position - global_position).length() >= distanceTarget:
		vel = Vector2(speed,0).rotated(rotation)

func atkMode(delta):
	shootTime -= 1 * delta
	if shootTime <= 0:
		if shooterType == 1:
			var bullet = bulletObj.instance()
			main.add_child(bullet)
			bullet.position = $Shooter1.global_position
			bullet.rotation = $Shooter1.global_rotation
			shootTime = shootTimeMax
		if shooterType == 2:
			var bullet = bulletObj.instance()
			main.add_child(bullet)
			bullet.position = $Shooter1.global_position
			bullet.rotation = $Shooter1.global_rotation
			var bullet2 = bulletObj.instance()
			main.add_child(bullet2)
			bullet2.position = $Shooter2.global_position
			bullet2.rotation = $Shooter2.global_rotation
			shootTime = shootTimeMax
		if shooterType == 3:
			var bullet = bulletObj.instance()
			main.add_child(bullet)
			bullet.position = $Shooter1.global_position
			bullet.rotation = $Shooter1.global_rotation
			var bullet2 = bulletObj.instance()
			main.add_child(bullet2)
			bullet2.position = $Shooter2.global_position
			bullet2.rotation = $Shooter2.global_rotation
			var bullet3 = bulletObj.instance()
			main.add_child(bullet3)
			bullet3.position = $Shooter3.global_position
			bullet3.rotation = $Shooter3.global_rotation
			shootTime = shootTimeMax
		if shooterType == 4:
			var bullet = bulletObj.instance()
			main.add_child(bullet)
			bullet.position = $Shooter1.global_position
			bullet.rotation = $Shooter1.global_rotation
			var bullet2 = bulletObj.instance()
			main.add_child(bullet2)
			bullet2.position = $Shooter2.global_position
			bullet2.rotation = $Shooter2.global_rotation
			var bullet3 = bulletObj.instance()
			main.add_child(bullet3)
			bullet3.position = $Shooter3.global_position
			bullet3.rotation = $Shooter3.global_rotation
			var bullet4 = bulletObj.instance()
			main.add_child(bullet4)
			bullet4.position = $Shooter4.global_position
			bullet4.rotation = $Shooter4.global_rotation
			shootTime = shootTimeMax
		if shooterType == 5:
			var bomb = bombObj.instance()
			main.add_child(bomb)
			bomb.position = $Shooter1.global_position
			bomb.rotation = $Shooter1.global_rotation
			shootTime = shootTimeMax
