extends RigidBody2D

var bulletBounce = false
var bounceCount = 0

var knockback = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func init_bullet(canBounce, doesKnockback):
	bulletBounce = canBounce
	knockback = doesKnockback

func _on_Area2D_body_entered(body): 
	if knockback:
		if "Enemy" in body.name:
			body.move_and_slide(transform.x.normalized() * 1000)
			queue_free()
	
	if bulletBounce and bounceCount < 1:
		bounceCount += 1
		return
	if bulletBounce and bounceCount >= 1:
		queue_free()
		
	if not "Player" in body.name and not "Bullet" in body.name:
		queue_free()
