class_name TargetedEffect
extends ActionEffect

@export var targetable_tags: Array[CharacterTag] = []
@export var tag_amount_needed: int = 1
@export var targeted: bool = true


func _init(p_targetable_tags: Array[CharacterTag] = [], p_tag_amount_needed: int = 1,
		p_targeted: bool = true) -> void:
	targetable_tags = p_targetable_tags
	tag_amount_needed = p_tag_amount_needed
	targeted = p_targeted


func _resolve(action_card: ActionCard) -> void:
	var enemy_holder: Hand = action_card.play_zone.enemy_holder
	if targeted:
		for target in get_valid_targets(action_card):
			target.enter_target_mode()
		
		var targeted_character: CharacterCard = await enemy_holder.target_found
		
		_resolve_with_target(action_card, targeted_character)
	else:
		for target in get_valid_targets(action_card):
			_resolve_with_target(action_card, target)


func get_valid_targets(action_card: ActionCard) -> Array[CharacterCard]:
	var enemy_holder: Hand = action_card.play_zone.enemy_holder
	var valid_targets: Array[CharacterCard] = []
	
	for enemy: CharacterCard in enemy_holder.cards:
		if is_valid_target(enemy):
			valid_targets.append(enemy)
	
	if is_valid_target(action_card.play_zone.player_card):
		valid_targets.append(action_card.play_zone.player_card)
	
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
