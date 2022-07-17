extends Node

var spawnAreas

var enemy = preload("res://Enemy.tscn")
var enemies = []
var player

var spawnTimeLeft = 0
var spawnRate = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_parent().get_node("Player")
	spawnAreas = get_children()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	spawnTimeLeft += delta
	if spawnTimeLeft > spawnRate:
		spawnTimeLeft = 0
		if spawnRate > 2:
			spawnRate -= 0.1
		
		spawnEnemy()
		
		
func spawnEnemy():
	var spawn = getFurthestSpawn()
	var enemyI = enemy.instance()
	enemyI.position = spawn.position
	enemyI.InitEnemy(player)
	get_tree().get_root().call_deferred("add_child", enemyI)
	
func getFurthestSpawn():
	var furthestSpawn
	var furthestDist = 0
	for s in spawnAreas:
		var d = player.global_transform.origin.distance_to(s.global_transform.origin)
		if d > furthestDist:
			furthestDist = d
			furthestSpawn = s
	return furthestSpawn
