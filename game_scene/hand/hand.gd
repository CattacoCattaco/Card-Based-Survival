class_name Hand
extends HBoxContainer

enum Mode {
	ACTIONS,
	ENEMIES,
}

@export var card_scene: PackedScene = preload("res://card/action_card/action_card.tscn")
@export var max_separation: int = 5
@export var cards: Array[Card] = []
@export var default_card: CardData
@export var play_zone: PlayZone
@export var deck_manager: DeckManager
@export var mode: Mode


func _ready() -> void:
	match mode:
		Mode.ACTIONS:
			draw_cards(4)
		Mode.ENEMIES:
			draw_cards(len(deck_manager.enemies))


func draw_cards(amount: int) -> void:
	for i in range(amount):
		_draw_card()
	
	recalc_card_separation()


func _draw_card() -> void:
	var card: Card = card_scene.instantiate()
	
	add_child(card)
	cards.append(card)
	
	card.hand = self
	card._load_data(deck_manager._get_next_card())


func recalc_card_separation() -> void:
	var combined_width: int = 125 * len(cards)
	var unused_space: int = custom_minimum_size.x - combined_width
	var separation_for_fill: int = floori(unused_space / (len(cards) - 1.0))
	
	add_theme_constant_override("separation", min(max_separation, separation_for_fill))
