extends Area2D
signal hit

@export var speed = 400 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	#hide()
	
	pass # Replace with function body.


func _on_body_entered(_body) -> void:
	hide()
	hit.emit() #emits a signal when hit
	#line below disables collision so player isnt hit more than once
	$CollisionShape2D.set_deferred("disabled", true) 
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
	
#movement handler
func _process(delta: float) -> void:
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.play()
	elif velocity.length() == 0 :
		$AnimatedSprite2D.animation = "idle"
		$AnimatedSprite2D.play()
		
	if velocity.x < 0:
		$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.flip_h = true
		
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	pass
