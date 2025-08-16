class_name GotoSettingsMenuEffect
extends ActionEffect

@export var menu: SettingsDeckManager.Menu = SettingsDeckManager.Menu.MENU_SELECT


func _init(p_menu: SettingsDeckManager.Menu = SettingsDeckManager.Menu.MENU_SELECT) -> void:
	menu = p_menu


func _resolve(action_card: ActionCard) -> void:
	var settings: Settings = action_card.play_zone.settings
	
	settings.hand.deck_manager.menu = menu


func _resolve_as_enemy_card(enemy_card: CharacterCard) -> void:
	var settings: Settings = enemy_card.play_zone.settings
	
	settings.hand.deck_manager.menu = menu
