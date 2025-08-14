class_name RefreshHandEffect
extends ActionEffect


func _resolve(action_card: ActionCard) -> void:
	action_card.hand.draw_hand()
