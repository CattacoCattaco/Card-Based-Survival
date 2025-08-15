class_name OpenSettingsEffect
extends ActionEffect


func _resolve(action_card: ActionCard) -> void:
	var play_zone: PlayZone = action_card.play_zone
	
	if play_zone.map_BG:
		play_zone.map_BG.map_control.load_settings()
	elif play_zone.fight:
		play_zone.fight.load_settings()
	
	action_card.hand.draw_specific_cards([action_card.data], false)
