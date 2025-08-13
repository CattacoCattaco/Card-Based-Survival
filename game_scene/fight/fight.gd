class_name Fight
extends Control

@export var enemy_queue_manager: EnemyQueueManager
@export var play_zone: PlayZone

var map_scene: Map


func return_to_map() -> void:
	get_tree().root.add_child(map_scene)
	
	map_scene.play_zone.player_card.current_health = play_zone.player_card.current_health
	map_scene.play_zone.player_card.current_money = play_zone.player_card.current_money
	map_scene.play_zone.player_card.update_stats()
	
	queue_free()
