extends KinematicBody2D

onready var main = get_parent()
onready var target = get_parent().get_node("Player")
onready var spawner = get_parent().get_node("Spawner")
var vel
export (int) var life
export (int) var speed = 200

func _physics_process(_delta):
	if main.isPaused == false:
		look_at(target.position)
		
		if life <= 0:
			$DestructSound.play()
			main.score += 135
			spawner.enemyCount -= 1
			queue_free()
		
		vel = Vector2(speed,0).rotated(rotation)
		vel = move_and_slide(vel)
	
		if (target.global_position - global_position).length() <= 50:
			spawner.enemyCount -= 1
			main.score += 135
			if target.isdefending == false:
				target.life -= 3
			queue_free()
