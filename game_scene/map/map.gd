class_name Map
extends Control

@export var play_zone: PlayZone
@export var map_bg: MapBG
@export var settings: Settings


func load_fight_scene(enemies: Array[CharacterData], attacked_object: MapObject) -> void:
	var fight_scene: Fight = preload("res://game_scene/fight/fight.tscn").instantiate()
	
	fight_scene.enemy_queue_manager.enemies = enemies
	fight_scene.map_scene = self
	fight_scene.settings = settings
	fight_scene.play_zone.settings = settings
	fight_scene.attacked_object = attacked_object
	fight_scene.play_zone.player_card.show_player_color()
	
	get_tree().root.add_child(fight_scene)
	get_tree().root.remove_child(self)


func load_settings() -> void:
	if not settings:
		settings = preload("res://game_scene/settings/settings.tscn").instantiate()
		settings.map_scene = self
		play_zone.settings = settings
		
		settings.from_screen = Settings.FromScreen.MAP
	else:
		settings.from_screen = Settings.FromScreen.MAP
		
		settings.hand.deck_manager.menu = SettingsDeckManager.Menu.MENU_SELECT
		settings.hand.draw_settings_hand()
	
	get_tree().root.remove_child.call_deferred(self)
	get_tree().root.add_child.call_deferred(settings)
