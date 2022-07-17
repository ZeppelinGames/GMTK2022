extends KinematicBody2D

var moveSpeed = 1
var Player

var motion = Vector2()
	
func InitEnemy(p):
	Player = p

func _physics_process(delta):
	if Player == null:
		return
	
	position += (Player.position - position).normalized() * moveSpeed
	look_at(Player.position)
	
	move_and_slide(motion)

func _on_Area2D_body_entered(body):
	if "Die" in body.name:
		queue_free()
