extends Node

@export var mob_scene: PackedScene
var score
var hp

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#new_game()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass

func game_over() -> void:
	$ScoreTimer.stop()
	$MobTimer.stop()
	$Music.stop()
	$DeathSound.play()
	$HUD.show_game_Over()
	
func new_game():
	hp = 5
	score = 0
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	$Player.start($StartPosition.position)
	$StartTimer.start()
	get_tree().call_group("mobs", "queue_free")
	$Music.play()

#waits for start timer to end before starting score count and mob spawning
func _on_start_timer_timeout() -> void:
	$MobTimer.start()
	$ScoreTimer.start()


func _on_score_timer_timeout():
	#print("I am: ", self.name)
	#print("My children are: ", get_children())
	score += 1
	$HUD.update_score(score)


func _on_mob_timer_timeout() -> void:
	#this creates a new enemy 
	var mob = mob_scene.instantiate()
	#selects a random spot along the 2d path
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()
	
	mob.position = mob_spawn_location.position
	#direction w/ some variation
	var direction = mob_spawn_location.rotation + PI/2
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction

	#speed of the enemy
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)

	#finally creates by adding it to main
	add_child(mob)
	
	
