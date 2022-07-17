extends RigidBody2D

var die_1 = preload("res://Dice/One.png")
var die_2 = preload("res://Dice/Two.png")
var die_3 = preload("res://Dice/Three.png")
var die_4 = preload("res://Dice/Four.png")
var die_5 = preload("res://Dice/Five.png")
var die_6 = preload("res://Dice/Six.png")

var dice = [
	die_1, die_2, die_3, die_4, die_5, die_6
]

class WeaponType:
	var doesBounce
	var doesKnockback
	
	func _init(b, k):
		doesBounce = b
		doesKnockback = k

var diceWeapons = [
	WeaponType.new(false, false),
	WeaponType.new(false, true),
	WeaponType.new(false, false),
	WeaponType.new(false, false),
	WeaponType.new(false, false),
	WeaponType.new(false, false)
]

onready var die_sprite = get_node("Die_Sprite")

var rolling = false
var rollTime = 1
var currRollTime

var dieState = 0

var player

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_parent().get_node("Player")
	die_sprite.set_texture(die_1)

func _process(delta):
	if rolling:
		apply_torque_impulse(25)
		currRollTime += delta
		
		if currRollTime > rollTime/2:
			dieState = rand_range(0,5)
			die_sprite.set_texture(dice[dieState])
			player.update_bullets(diceWeapons[dieState].doesBounce, diceWeapons[dieState].doesKnockback)
			
		if currRollTime > rollTime:
			rolling = false

func _on_Area2D_body_entered(body):
	if "Player" in body.name:
		if rolling == false:
			apply_impulse(Vector2(), (body.global_position - global_position).normalized() * 500)
			currRollTime = 0
			rolling = true
