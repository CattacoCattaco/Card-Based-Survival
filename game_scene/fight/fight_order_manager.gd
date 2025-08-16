class_name FightOrderManager
extends Node

@export var player_card: CharacterCard
@export var enemy_holder: Hand
@export var play_zone: PlayZone

var turn_order: Array[CharacterCard] = []
var current_character_index: int = 0


func _ready() -> void:
	play_zone.is_player_turn = false
	
	turn_order.append(player_card)
	await enemy_holder.enemies_loaded
	_add_enemies_to_turn_order()
	_do_turn_cycle()


func _add_enemies_to_turn_order() -> void:
	for enemy_card: CharacterCard in enemy_holder.cards:
		turn_order.append(enemy_card)


func _do_turn_cycle() -> void:
	while true:
		var next_card: CharacterCard = turn_order[current_character_index]
		next_card.highlight()
		await next_card.do_turn()
		next_card.unhighlight()
		_advance_turn()


func _advance_turn() -> void:
	current_character_index += 1
	if current_character_index >= len(turn_order):
		current_character_index = 0
		
		for character in turn_order:
			if not character:
				return
			character.current_energy = character.current_max_energy
			character.update_energy()
