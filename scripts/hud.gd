extends CanvasLayer
signal start_game

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ScoreLabel.hide()
	$Health.hide()
	$Message.hide()
	$Title.show()
	$timeLabel.hide()
	pass # Replace with function body.

func show_message(text):
		$Message.text = text
		$Message.show()
		$MessageTimer.start()
		
func hide_message():
		$Message.hide()

func updateHealth(text):
		$Health.text = "HP : " + str(text)
		#$Health.show()
		
func show_game_Over():
		show_message("Game Over")
		$Health.hide()
		await $MessageTimer.timeout
		
		$timeLabel.hide()
		$Health.hide()
		$ScoreLabel.hide()

		#$Message.text = "Fox Survivors!"
		
		await get_tree().create_timer(1.0).timeout
		$roundLabel.hide()
		$Message.hide()
		$Title.show()
		$StartButton.show()
		$QuitButton.show()
		$fox.show()
		$ScoreLabel.hide()

func update_score(score): #used for money now
	$ScoreLabel.text = "$" + str(score)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	updateHealth(Global.playerHealth)
	pass


func _on_start_button_pressed() -> void:
	$timeLabel.show()
	$ScoreLabel.show()
	$Title.hide()
	$QuitButton.hide()
	$StartButton.hide()
	$fox.hide()
	start_game.emit()
	$Health.show()
	$roundLabel.show()

func updateRound():
	$roundLabel.text = "Round : " + str(Global.round)

func _on_message_timer_timeout() -> void:
	$Message.hide()


func _on_quit_button_pressed() -> void:
	get_tree().quit()

func updateTime(time):
	$timeLabel.text = str(int(time))
