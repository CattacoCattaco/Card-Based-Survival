class_name DamageEffect
extends ActionEffect

@export var targeted: bool = true
@export var base_amount: int = 0
@export var strength_amount: int = 1


func _init(p_targeted: bool = true, p_base_amount: int = 0, p_strength_amount: int = 1) -> void:
	targeted = p_targeted
	base_amount = p_base_amount
	strength_amount = p_strength_amount


func _resolve(action_card: ActionCard) -> void:
	var enemy_holder: Hand = action_card.hand.play_zone.enemy_holder
	
	for enemy: CharacterCard in enemy_holder.cards:
		enemy.enter_target_mode()
	
	var targeted_enemy: CharacterCard = await enemy_holder.target_found
	
	var strength: int = action_card.hand.play_zone.player_card.current_strength
	
	var damage_amount: int = strength_amount * strength + base_amount
	damage_amount -= targeted_enemy.current_block
	
	if damage_amount > 0:
		targeted_enemy.current_health -= damage_amount
	
	if targeted_enemy.current_health <= 0:
		targeted_enemy.die()
	
	targeted_enemy.update_health()
