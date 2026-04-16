extends Node

@export var mob_scene: PackedScene
@export var obj_scene: PackedScene

var score
var roundLength = 30
var maxMob = 10
var mobAmount = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Player.set_player_position($StartPosition.position)
	#new_game()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var offset = Vector2(get_viewport().size / 2)
	$MobPath.global_position = $Player.global_position - offset
	$HUD.updateTime($RoundTimer.time_left)
	pass



func playerHit() -> void:
	
	$HUD.updateHealth(str(Global.playerHealth))
	print("hi" + str(Global.playerHealth))
	if Global.playerHealth <= 0 :
		Global.gameState = 0
		$HUD.updateHealth(Global.playerHealth)
		$ScoreTimer.stop()
		$RoundTimer.stop()
		$MobTimer.stop()
		$Music.stop()
		$DeathSound.play()
		$HUD.show_game_Over()
		Global.playerHealth = 99999
	
	
func new_game():
	get_tree().call_group("mobs", "queue_free")
	get_tree().call_group("weapon", "queue_free")
	get_tree().call_group("objects", "queue_free")
	
	Global.gameState = 1
	Global.playerHealth = 5
	print(Global.playerHealth)
	score = 0
	$Player.start($StartPosition.position)
	Global.maxWeapons = 6
	Global.round = 1
	Global.money = 0 
	maxMob = 10
	mobAmount = 0
	
	createObj("Chest",Vector2(-100,1))
	
	new_round()
	$Music.play()

#waits for start timer to end before starting score count and mob spawning
func _on_start_timer_timeout() -> void:
	$MobTimer.start()
	$ScoreTimer.start()
	$RoundTimer.start()


func _on_score_timer_timeout():
	#print("I am: ", self.name)
	#print("My children are: ", get_children())
	score += 1
	$HUD.update_score(Global.money)
	#$HUD.update_score(score)



func _on_mob_timer_timeout() -> void:
	if (Global.gameState == 0):
		$MobTimer.stop()
		$RoundTimer.stop()
		return
	#this creates a new enemy 
	if(mobAmount >= maxMob):
		return
	var mob
	var rand = randf()
	if (Global.round < 3 or rand < 0.9):
		mob = mob_scene.instantiate()
	elif (Global.round >= 3):
		#tank
		mob = mob_scene.instantiate() #tank
		mob.speed = 75
		mob.value = 5
		mob.hp = 10
		mob.type = 2
		pass
	mobAmount += 1
	#selects a random spot along the 2d path
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()
	
	mob.global_position = mob_spawn_location.global_position
	
	#mob.player = $Player
	#direction w/ some variation
	#var direction = mob_spawn_location.rotation + PI/2
	#direction += randf_range(-PI / 4, PI / 4)
	#mob.rotation = direction

	#speed of the enemy
	#var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	#mob.linear_velocity = velocity.rotated(direction)

	#finally creates by adding it to main
	add_child(mob)
	
	

func add_weapon(weapon):
	$Player.newWeapon(weapon)
	pass


func _on_round_timer_timeout() -> void:
	if Global.gameState == 1 :
		end_round()
		Global.round += 1
		
func end_round():
	mobAmount = 0
	$MobTimer.stop()
	get_tree().call_group("mobs", "queue_free")
	$HUD.show_message("End Round")
	shop()
	
func shop():
	await get_tree().create_timer(2.5).timeout
	$Shop.shopStart()
	#$HUD.show_message("")
	#$HUD.hide_message()
	$Shop.show()
	await $Shop.exited
	$Shop.hide()
	new_round()
		#await get_tree().create_timer(5.0).timeout
		#new_round()
		#$HUD.hide_message()
		#pass

func new_round():
	maxMob = maxMob * 1.5
	print(str(Global.round))
	#$HUD.updateHealth(str(Global.playerHealth))
	$MobTimer.wait_time = max(0.1, 1.0 - (Global.round * 0.05))
	print("spawn wait : " + str($MobTimer.wait_time))
	$RoundTimer.wait_time = 28+(Global.round * 2)
	$HUD.updateHealth(str(Global.playerHealth))
	$HUD.update_score(Global.money)
	$HUD.show_message("Get Ready")
	if (Global.gameState == 0):
		return
	$HUD.updateRound()
	$StartTimer.start()
	pass

func createObj(inputType, pos):
	var obj = obj_scene.instantiate()
	obj.type = inputType
	obj.global_position = pos
	obj.z_index = 0
	add_child(obj)
	pass
