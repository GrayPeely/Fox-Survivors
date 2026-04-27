extends Area2D
signal hit

@onready var animHit = $hitAnim
@export var sword_scene: PackedScene
var playerSpeed = 400 # How fast the player will move (pixels/sec).
var screen_size = Vector2(500, 500) # Size of the f window.
var weaponNum = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("begin speed" + str(playerSpeed))
	screen_size = get_viewport_rect().size
	hide()
	
	pass # Replace with function body.


func _on_body_entered(_body) -> void:
	if(_body is TileMapLayer):
		return
	Global.playerHealth -= 1
	animHit.play("hitAnim")
	hit.emit()
	if Global.playerHealth <= 0 :
		 #emits a signal when hit
		$CollisionShape2D.set_deferred("disabled", true)
		hide()
		return
	#line below disables collision so player isnt hit more than once
	$CollisionShape2D.set_deferred("disabled", true)
	await get_tree().create_timer(1).timeout
	$CollisionShape2D.set_deferred("disabled", false)
	print(str(Global.playerHealth))
	
	
func start(pos):
	
	screen_size = get_viewport_rect().size
	set_player_position(pos)
	show()
	$CollisionShape2D.disabled = false
	newWeapon(Global.weaponPool[0])
	
func set_player_position(pos2):
	position = pos2
#movement handler
func _process(delta: float) -> void:
	#print(str(position))
	if(Global.gameState == 0):
		return
	var velocity = Vector2.ZERO
	playerSpeed = 400 + Global.speedMult
	#print(playerSpeed)
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
		if(position.x >= 3150):
			velocity.x = 0
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
		if(position.x <= -3150):
			velocity.x = 0
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
		if(position.y <= -3150):
			velocity.y = 0
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
		if(position.y >= 3150):
			velocity.y = 0
	#if Input.is_action_pressed("addWeapon"):
		#newWeapon("sword", 1)
	#print("velocity" + str(velocity))
	#print("speeed" + str(playerSpeed))
	if velocity.length() > 0:
		velocity = velocity.normalized() * playerSpeed
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
	#position = position.clamp(Vector2.ZERO, screen_size)
	Global.weaponList = $WeaponHandler.get_children()
	#print($WeaponHandler.get_children())
	pass


func _on_hit() -> void:
	pass # Replace with function body.
	
func newWeapon(weaponEntered):
	var weapon

	if("Axe" in weaponEntered["Name"] or "Sword" in weaponEntered["Name"]):
		weapon = sword_scene.instantiate()
		#print(str(weapon))
		weapon.swordNum = weaponEntered["State"] + 1
		weapon.weaponType = weaponEntered
	$WeaponHandler.add_child(weapon)
	positionWeapon()
	
func positionWeapon():
	var weapons = $WeaponHandler.get_children()
	#for i in weapons.size() :
		#print("help" + str(i))
	var radius = 60 
	
	for i in weapons.size() :
		weapons[i].rotation_degrees = i*360/weapons.size()
		weapons[i].get_node("Area2D/Sprite2D").position.x = radius
		weapons[i].get_node("Area2D/CollisionShape2D").position.x = radius

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("addWeapon") :
		#rework chests
		var areas = get_overlapping_areas()
		for a in areas:
			# Check if the area has the chest_open function
			if a.has_method("chest_open"):
				a.chest_open()
				# This stops the loop so you don't open 2 chests if they overlap
				return
		pass
		

#func _on_attack_timer_timeout() -> void:
	#var weapons = $WeaponHandler.get_children()
	#
	#for weapon in weapons:
		#
		## Tell the sword to run its lunge function
		#if weapon.has_method("attackNorm"):
			#weapon.attackNorm()



func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("projectiles"):
		Global.playerHealth -= 1
		area.queue_free()
		hit.emit()
		animHit.play("hitAnim")
		if Global.playerHealth <= 0 :
			 #emits a signal when hit
			$CollisionShape2D.set_deferred("disabled", true)
			hide()
			return
		$CollisionShape2D.set_deferred("disabled", true)
		await get_tree().create_timer(1).timeout
		$CollisionShape2D.set_deferred("disabled", false)
		print(str(Global.playerHealth))
	pass # Replace with function body.
