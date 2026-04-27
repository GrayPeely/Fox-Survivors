extends Node2D
var dmg = Global.damage 
var attackS = Global.attackSpeed
var wait = 1
var range = Global.range
var swordNum = 1
var weaponType = Global.weaponPool[0]
var norm = .9
var tweenLength = 0.3

#PLEASE NOTE THAT ATTACK SPEED IS  MODIFIED IN THE SWORD ITSELF
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if "Axe" in weaponType["Name"] :
		norm = 2
		range = 100 + Global.range - 60
	$Area2D/Sprite2D.texture = weaponType["Icon"]
	$AttackTime.wait_time = norm / (1.0 * attackS)
	update()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass

func update():
	attackS = Global.attackSpeed
	dmg = Global.damage + weaponType["Damage"]
	tweenLength = (0.3 * norm) / (1.0 * attackS)
	$AttackTime.wait_time = norm / (attackS * 1.0)

func _on_area_2d_body_entered(body: Node2D) -> void:
	update()
	if body.is_in_group("mob"):
		#print("yo")
		if body.has_method("damage"):
			body.damage(dmg) 

func get_enemy():
	var enemies = get_tree().get_nodes_in_group("mob")
	var closest_enemy
	var shortest_dist = 1000000067
	
	for i in enemies:
		var dist = global_position.distance_to(i.global_position)
		if dist < shortest_dist and not Global.targeted.has(i):
			shortest_dist = dist
			closest_enemy = i
	return closest_enemy
	
func attackNorm():
	var target_enemy = get_enemy()
	if target_enemy:
		Global.targeted.append(target_enemy)
		look_at(target_enemy.global_position)
		var tween = create_tween()
		var original_pos = position
		var target_pos = original_pos + Vector2.RIGHT.rotated(rotation) * range
		tween.tween_property(self, "position", target_pos, tweenLength)
		tween.tween_property(self, "position", original_pos, tweenLength)
		await tween.finished
		Global.targeted.erase(target_enemy)

func get_type():
	return weaponType


func _on_attack_time_timeout() -> void:
	attackNorm()
	pass # Replace with function body.
