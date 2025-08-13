class_name EnemyQueueManager
extends DeckManager


var enemies: Array[CharacterData]


func _get_next_card() -> CardData:
	return enemies.pop_back()
