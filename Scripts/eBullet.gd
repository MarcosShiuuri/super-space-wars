extends Area2D

const particleObj = preload("res://Scenes/Particles.tscn")
onready var main = get_parent()
var bulletPos
const bulletSpeed = 500
var timer = 3

func _physics_process(delta):
	if main.isPaused == false:
		bulletPos = Vector2(bulletSpeed * delta,0).rotated(rotation)
		translate(bulletPos)
		
		timer -= 1 * delta
		if timer <= 0:
			self.queue_free()


func _on_eBullet_area_entered(area):
	if area.name == "PhurtArea":
		var target = area.get_parent()
		if target.isdefending == false:
			target.life -= 1
		var particle = particleObj.instance()
		main.add_child(particle)
		particle.global_position = self.global_position
		queue_free()
	if area.name == "ShieldArea":
		queue_free()
