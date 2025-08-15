class_name CharacterCard
extends Card

@export var target_sprite: Sprite2D

@export var health_label: Label
@export var block_label: Label
@export var strength_label: Label
@export var energy_label: Label
@export var money_label: Label

@export var fight_deck: Array[ActionData]
@export var movement_deck: Array[ActionData]

@export var player_tag: CharacterTag

var current_health: int
var current_block: int
var current_strength: int
var current_energy: int
var current_money: int

var in_target_mode: bool = false


func show_player_color() -> void:
	set_art_replace_color(play_zone.settings.get_player_color())


func _load_data(new_data: CardData) -> void:
	if new_data is not CharacterData:
		return
	
	super(new_data)
	
	current_health = data.health
	current_block = data.block
	current_strength = data.strength
	current_energy = data.energy
	current_money = data.money
	
	update_stats()


func update_stats() -> void:
	update_health()
	update_block()
	update_strength()
	update_energy()
	update_money()


func update_health() -> void:
	health_label.text = "%s/%s" % [current_health, data.health]


func update_block() -> void:
	block_label.text = str(current_block)


func update_strength() -> void:
	strength_label.text = str(current_strength)


func update_energy() -> void:
	energy_label.text = "%s/%s" % [current_energy, data.energy]


func update_money() -> void:
	money_label.text = str(current_money)


func enter_target_mode() -> void:
	in_target_mode = true
	target_sprite.show()


func leave_target_mode() -> void:
	in_target_mode = false
	target_sprite.hide()


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if in_target_mode:
				for card: CharacterCard in hand.cards:
					card.leave_target_mode()
				
				play_zone.player_card.leave_target_mode()
				
				hand.target_found.emit(self)


func die() -> void:
	if is_player():
		pass
	else:
		hand.cards.erase(self)
		
		play_zone.player_card.current_money += current_money
		
		if not hand.cards:
			play_zone.fight.return_to_map(true)
	
	queue_free()


func is_player() -> bool:
	return has_tag(player_tag)


func has_tag(match_tag: CharacterTag) -> bool:
	for present_tag: CharacterTag in data.tags:
		if present_tag.inherits(match_tag):
			return true
	
	return false
