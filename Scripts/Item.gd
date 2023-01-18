extends Area2D

onready var main = get_parent()
onready var player = get_parent().get_node("Player") 
export (int) var itemType = 1

var timer = 15

func _physics_process(delta):
	if main.isPaused == false:
		timer -= 1 * delta
		if timer <= 0:
			queue_free()

func _on_ShootItem_area_entered(area):
	if area.name == "PhurtArea":
		main.score += 200
		if itemType == 1:
			if player.shooters < 3:
				player.shooters += 1
			else:
				player.shooters = 3
		if itemType == 2:
			if player.isdefending == false:
				player.isdefending = true
			else:
				player.isdefending = true
		if itemType == 3:
			if player.speed < 600:
				player.speed += 100
			else:
				player.speed = 600
		if itemType == 4:
			if player.life < 50:
				player.life += 5
			else:
				player.life = 50
		#Instanciar partículas
		queue_free()
