extends RigidBody2D
var hp = 5
var speed = 148.77
var player
var value = 1
var type = 1
@export var coin : PackedScene
@export var projectile : PackedScene
@onready var hitAnim = $hitFlash

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().root.get_node("Main/Player")
	if type == 1 :
		$AnimatedSprite2D.animation == "enemy1"
		$AnimatedSprite2D.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var distance = global_position.distance_to(player.global_position)
	var direction = global_position.direction_to(player.global_position)
	var speed1 = speed
	if distance < (300 - 20):
		direction = -direction
	elif distance > (300 + 20):
		pass
	else:
		speed1 = 0.0
	
	linear_velocity = direction * speed1
	pass

func hpUpdate():
	$Label.text = str(hp)
	
func damage(amount):
	hp = hp - amount
	print(str(hp))
	hpUpdate()
	if hp <= 0 :
		call_deferred("death")
		
func death():
	set_process(false)
	collision_layer = 0
	collision_mask = 0
	freeze = true
	var newCoin = coin.instantiate()
	newCoin.value = value
	get_tree().root.get_node("Main").add_child(newCoin)
	newCoin.global_position = global_position
	get_parent().mobAmount -= 1
	
	queue_free()

func _on_attack_timer_timeout() -> void:
	var proj = projectile.instantiate()
	proj.damage = 1
	proj.dir = global_position.direction_to(player.global_position)
	get_tree().root.get_node("Main").add_child(proj)
	proj.global_position = self.global_position
	
