extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _input(event) -> void:
	if event.is_action_pressed("pause_game") :
		if Global.gameState == 1 :
			var is_paused = !get_tree().paused
			get_tree().paused = is_paused
			visible = is_paused



func _on_button_pressed() -> void:
	var is_paused = !get_tree().paused
	get_tree().paused = is_paused
	visible = is_paused
	


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_end_run_pressed() -> void:
	_on_button_pressed()
	Global.playerHealth = 0
	get_tree().root.get_node("Main").playerHit()
	pass # Replace with function body.
