class_name Fight
extends Control

@export var enemy_queue_manager: EnemyQueueManager
@export var play_zone: PlayZone

var settings: Settings
var map_scene: Map
var attacked_object: MapObject


func return_to_map(won: bool) -> void:
	if won:
		map_scene.map_bg.objects.erase(attacked_object.pos)
		map_scene.map_bg.visible_objects.erase(attacked_object.pos)
		attacked_object.queue_free()
	
	get_tree().root.add_child(map_scene)
	
	map_scene.play_zone.player_card.current_health = play_zone.player_card.current_health
	map_scene.play_zone.player_card.current_money = play_zone.player_card.current_money
	map_scene.play_zone.player_card.update_stats()
	
	settings.fight_scene = null
	
	queue_free()


func load_settings() -> void:
	settings.fight_scene = self
	settings.from_screen = Settings.FromScreen.FIGHT
	
	settings.hand.deck_manager.menu = SettingsDeckManager.Menu.MENU_SELECT
	settings.hand.draw_settings_hand()
	
	get_tree().root.remove_child.call_deferred(self)
	get_tree().root.add_child.call_deferred(settings)
