extends Node2D

onready var main = get_parent()
onready var player = get_parent().get_node("Player")

export (Array) var spawnPoints
export (Array, PackedScene) var enemies
export (Array, PackedScene) var specials

var timer = 0
var timerMax = 4.5
var itemTimer = 0
var itemTimerMax = 7
var enemyCount = 0
var maxEnemies = 7

func _ready():
	randomize()
	spawnPoints[0] = $"0"
	spawnPoints[1] = $"1"
	spawnPoints[2] = $"2"
	spawnPoints[3] = $"3"
	spawnPoints[4] = $"4"
	spawnPoints[5] = $"5"
	spawnPoints[6] = $"6"
	spawnPoints[7] = $"7"
	spawnPoints[8] = $"8"
	spawnPoints[9] = $"9"
	spawnPoints[10] = $"10"
	spawnPoints[11] = $"11"
	spawnPoints[12] = $"12"
	spawnPoints[13] = $"13"

func _physics_process(delta):
	if main.isPaused == false:
		self.global_position = player.global_position
		timer -= 1 * delta
		
		if timer <= 0 && enemyCount < maxEnemies:
			var enemy = enemies[rand_range(0,9)].instance()
			enemy.position = spawnPoints[rand_range(0,14)].global_position
			main.add_child(enemy)
			enemyCount += 1
			if timerMax > 0.5:
				timerMax -= 0.1
			else:
				timer = 0
			timer = timerMax
		
		itemTimer -= 1 * delta
		if itemTimer <= 0:
			var item = specials[rand_range(0,8)].instance()
			item.position = spawnPoints[rand_range(0,14)].global_position
			main.add_child(item)
			itemTimer = itemTimerMax
