extends Area2D

onready var main = get_parent()
onready var target = get_parent().get_node("Player")
var bombPos
export (int) var bombSpeed = 300
export (int) var timer = 3

func _physics_process(delta):
	if main.isPaused == false:
		look_at(target.position)
		
		if (target.global_position - global_position).length() >= 40:
			bombPos = Vector2(bombSpeed * delta,0).rotated(rotation)
			translate(bombPos)
		if	(target.global_position - global_position).length() < 40:
			if target.isdefending == false:
				target.life -= 2
			#AtivarParticles
			queue_free()
		
		timer -= 1 * delta
		if timer <= 0:
			self.queue_free()
