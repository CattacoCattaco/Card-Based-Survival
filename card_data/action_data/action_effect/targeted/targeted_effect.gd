class_name TargetedEffect
extends ActionEffect

@export var targetable_tags: Array[CharacterTag] = []
@export var tag_amount_needed: int = 1
@export var targeted: bool = true
@export var value: float = 0


func _init(p_targetable_tags: Array[CharacterTag] = [], p_tag_amount_needed: int = 1,
		p_targeted: bool = true, p_value: float = 0) -> void:
	targetable_tags = p_targetable_tags
	tag_amount_needed = p_tag_amount_needed
	targeted = p_targeted
	value = p_value


func _resolve(action_card: ActionCard) -> void:
	var enemy_holder: Hand = action_card.play_zone.enemy_holder
	if targeted:
		for target in get_valid_targets(enemy_holder, action_card.play_zone.player_card):
			target.enter_target_mode()
		
		var targeted_character: CharacterCard = await enemy_holder.target_found
		
		_resolve_with_target(action_card, targeted_character)
	else:
		for target in get_valid_targets(enemy_holder, action_card.play_zone.player_card):
			_resolve_with_target(action_card, target)


func _resolve_as_enemy_card(enemy_card: CharacterCard) -> void:
	var enemy_holder: Hand = enemy_card.hand
	if targeted:
		var valid_targets: Array[CharacterCard]
		valid_targets = get_valid_targets(enemy_holder, enemy_card.play_zone.player_card)
		
		var target_player: bool = randf() < (1.0 - value) / 2.0
		for valid_target in valid_targets:
			if valid_target in enemy_holder.cards:
				if len(valid_targets) > 1 and target_player:
					valid_targets.erase(valid_target)
			else:
				if len(valid_targets) > 1 and not target_player:
					valid_targets.erase(valid_target)
		
		var targeted_character: CharacterCard = valid_targets.pick_random()
		
		_resolve_as_enemy_card_with_target(enemy_card, targeted_character)
	else:
		for target in get_valid_targets(enemy_holder, enemy_card.play_zone.player_card):
			_resolve_as_enemy_card_with_target(enemy_card, target)


func get_valid_targets(enemy_holder: Hand, player_card: CharacterCard) -> Array[CharacterCard]:
	var valid_targets: Array[CharacterCard] = []
	
	for enemy: CharacterCard in enemy_holder.cards:
		if is_valid_target(enemy):
			valid_targets.append(enemy)
	
	if is_valid_target(player_card):
		valid_targets.append(player_card)
	
	return valid_targets


func is_valid_target(card: CharacterCard) -> bool:
	if tag_amount_needed == 0:
		return true
	
	var tags_matched: int = 0
	
	for targetable_tag in targetable_tags:
		if card.has_tag(targetable_tag):
			tags_matched += 1
			
			if tags_matched >= tag_amount_needed:
				return true
			
			break
	
	return false


func _resolve_with_target(_action_card: ActionCard, _targeted_character: CharacterCard) -> void:
	pass


func _resolve_as_enemy_card_with_target(_enemy_card: CharacterCard,
		_targeted_character: CharacterCard) -> void:
	pass
