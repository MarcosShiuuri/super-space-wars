extends Area2D

onready var main = get_parent()
const particleObj = preload("res://Scenes/Particles.tscn")
var bulletPos
const bulletSpeed = 1500
var timer = 1

func _physics_process(delta):
	if main.isPaused == false:
		bulletPos = Vector2(bulletSpeed * delta,0).rotated(rotation)
		translate(bulletPos)
		
		timer -= 1 * delta
		if timer <= 0:
			self.queue_free()

func _on_pBullet_area_entered(area):
	if area.collision_layer == 2:
		var target
		target = area.get_parent()
		target.life -= 1
		var particle = particleObj.instance()
		main.add_child(particle)
		particle.global_position = self.global_position
		queue_free()
