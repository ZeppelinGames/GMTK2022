extends KinematicBody2D

var bulletSpeed = 500
var moveSpeed = 100

var dieHitSpeed = 100

var bullet = preload("res://Bullet.tscn")

var doesBounce = false
var doesKnockback = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	var motion = Vector2()
	
	if Input.is_action_pressed("up"):
		motion.y -= 1
	if Input.is_action_pressed("down"):
		motion.y += 1
	if Input.is_action_pressed("left"):
		motion.x -= 1
	if Input.is_action_pressed("right"):
		motion.x += 1
	
	motion = motion.normalized()
	motion = move_and_slide(motion * moveSpeed)
	
	look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("Fire"):
		fire()
	
func fire():
	var bulletInstance = bullet.instance()
	bulletInstance.init_bullet(doesBounce, doesKnockback)
	bulletInstance.position = get_global_position() + (transform.x*15)
	bulletInstance.rotation_degrees = rotation_degrees
	bulletInstance.apply_impulse(Vector2(), Vector2(bulletSpeed, 0).rotated(rotation))
	get_tree().get_root().call_deferred("add_child", bulletInstance)
	
func kill():
	pass
	#player deaded
	#get_tree().reload_current_scene()

func update_bullets(b, k):
	doesBounce = b
	doesKnockback = k

func _on_Area2D_body_entered(body):
	if "Enemy" in body.name:
		kill()
	if "Die" in body.name:
		body.apply_impulse(Vector2(), (position - body.position).normalized() * dieHitSpeed)
		#reroll die
