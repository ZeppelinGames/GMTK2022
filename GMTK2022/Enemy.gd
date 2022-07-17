extends KinematicBody2D

var moveSpeed = 100
var Player

var motion = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	Player = get_parent().get_node("Player")

func _physics_process(delta):
	position += (Player.position - position).normalized() * moveSpeed
	look_at(Player.position)
	
	move_and_collide(motion)

func _on_Area2D_body_entered(body):
	if "Bullet" in body.name:
		queue_free()
