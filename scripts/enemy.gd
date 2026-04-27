extends RigidBody2D
var hp = 5
var speed = 135
var player
var value = 1
var type = 1
@export var coin : PackedScene
@onready var hitAnim = $hitFlash

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	player = get_tree().root.get_node("Main/Player")
	if(type == 1):
		$CollisionShape2D.scale = Vector2(1.0, 1.0)
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.play()
	if(type == 2):
		$CollisionShape2D.scale = Vector2(1.5, 1.5)
		$AnimatedSprite2D.animation = "tankWalk"
		$AnimatedSprite2D.play()
		speed = 75
		value = 5
		hp = 10
		type = 2
		
	if Global.round > 1:
		hp = hp + Global.round/2 - .5
	updateHealth()	
	speed = speed + (sqrt(Global.round) * 30)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
		updateHealth()
		# 1. Calculate the direction to the player
		var direction = global_position.direction_to(player.global_position)
		
		linear_velocity = direction * speed
		
		# 3. Flip the sprite to look at the player
		if direction.x > 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
		
		
func updateHealth():
	
	$EnemyHealth.text = str(hp)
	
func damage(amount):
	hp = hp - amount
	updateHealth()
	hitAnim.play("hitFlash")
	if hp <= 0 :
		call_deferred("die")#Global.money += 1
		
		
func die():
	set_process(false)
	var newCoin = coin.instantiate()
	newCoin.value = value
	get_tree().root.get_node("Main").add_child(newCoin)
	newCoin.global_position = global_position
	get_tree().root.get_node("Main/HUD").update_score(Global.money)
	get_parent().mobAmount -= 1
	await hitAnim.animation_finished
	queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	#queue_free()
	pass
