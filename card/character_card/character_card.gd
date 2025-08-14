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

var current_health: int
var current_block: int
var current_strength: int
var current_energy: int
var current_money: int

var in_target_mode: bool = false


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
				for card in hand.cards:
					card.leave_target_mode()
				
				hand.play_zone.player_card.leave_target_mode()
				
				hand.target_found.emit(self)


func die() -> void:
	hand.play_zone.player_card.current_money += current_money
	
	hand.cards.erase(self)
	
	if not hand.cards:
		hand.play_zone.fight.return_to_map()
	
	queue_free()
