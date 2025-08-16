class_name ActionEffect
extends Resource


@warning_ignore("unused_parameter")
func _resolve(action_card: ActionCard) -> void:
	# Dummy Coroutine to make godot know this sometimes is one
	var timer := Timer.new()
	timer.start(0.1)
	await timer.timeout


@warning_ignore("unused_parameter")
func _resolve_as_enemy_card(enemy_card: CharacterCard) -> void:
	pass


@warning_ignore("unused_parameter")
func _resolve_as_enemy_object(enemy_object: MapObject) -> void:
	pass
