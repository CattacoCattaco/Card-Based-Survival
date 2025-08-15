class_name ReturnFromSettingsEffect
extends ActionEffect


func _resolve(action_card: ActionCard) -> void:
	var settings: Settings = action_card.play_zone.settings
	
	match settings.from_screen:
		Settings.FromScreen.MAP:
			settings.return_to_map()
		Settings.FromScreen.FIGHT:
			settings.return_to_fight()
