class_name TargetedDamageEffect
extends TargetedEffect

@export var base_amount: int = 0
@export var strength_amount: int = 1


func _init(p_targetable_tags: Array[CharacterTag] = [], p_tag_amount_needed: int = 1,
		p_targeted: bool = true, p_value: float = 0, p_base_amount: int = 0,
		p_strength_amount: int = 1) -> void:
	super(p_targetable_tags, p_tag_amount_needed, p_targeted, p_value)
	base_amount = p_base_amount
	strength_amount = p_strength_amount


func _resolve_with_target(action_card: ActionCard, targeted_character: CharacterCard) -> void:
	var strength: int = action_card.play_zone.player_card.current_strength
	
	var damage_amount: int = strength_amount * strength + base_amount
	
	if damage_amount < 0:
		targeted_character.current_health -= damage_amount
		
		if targeted_character.current_health >= targeted_character.current_max_health:
			targeted_character.current_health = targeted_character.current_max_health
	else:
		damage_amount -= targeted_character.current_block
		
		if damage_amount > 0:
			targeted_character.current_health -= damage_amount
		
		if targeted_character.current_health <= 0:
			targeted_character.die()
	
	targeted_character.update_health()


func _resolve_as_enemy_card_with_target(enemy_card: CharacterCard,
		targeted_character: CharacterCard) -> void:
	var strength: int = enemy_card.current_strength
	
	var damage_amount: int = strength_amount * strength + base_amount
	
	if damage_amount < 0:
		targeted_character.current_health -= damage_amount
		
		if targeted_character.current_health >= targeted_character.current_max_health:
			targeted_character.current_health = targeted_character.current_max_health
	else:
		damage_amount -= targeted_character.current_block
		
		if damage_amount > 0:
			targeted_character.current_health -= damage_amount
		
		if targeted_character.current_health <= 0:
			targeted_character.die()
	
	targeted_character.update_health()
