class_name Hand
extends HBoxContainer

@warning_ignore("unused_signal")
signal target_found(target: Card)

enum Mode {
	ACTIONS,
	ENEMIES,
}

@export var card_scene: PackedScene = preload("res://card/action_card/action_card.tscn")
@export var max_separation: int = 5
@export var cards: Array[Card] = []
@export var always_available_cards: Array[CardData]
@export var play_zone: PlayZone
@export var deck_manager: DeckManager
@export var mode: Mode


func _ready() -> void:
	match mode:
		Mode.ACTIONS:
			draw_hand()
		Mode.ENEMIES:
			draw_cards(len(deck_manager.enemies))


func draw_hand() -> void:
	for card in cards:
		if card.from_deck:
			deck_manager.used_cards.append(card.data)
		
		card.queue_free()
	
	cards = []
	
	draw_cards(4)
	draw_specific_cards(always_available_cards, false)


func draw_cards(amount: int, from_deck: bool = true) -> void:
	for i in range(amount):
		_draw_card(deck_manager._get_next_card(), from_deck)
	
	recalc_card_separation()


func draw_specific_cards(cards_to_draw: Array[CardData], from_deck: bool = true) -> void:
	for card in cards_to_draw:
		_draw_card(card, from_deck)
	
	recalc_card_separation()


func _draw_card(data: CardData, from_deck: bool) -> void:
	var card: Card = card_scene.instantiate()
	
	add_child(card)
	cards.append(card)
	
	card.hand = self
	card._load_data(data)
	card.from_deck = from_deck


func recalc_card_separation() -> void:
	var combined_width: int = 125 * len(cards)
	@warning_ignore("narrowing_conversion")
	var unused_space: int = custom_minimum_size.x - combined_width
	var separation_for_fill: int = floori(unused_space / (len(cards) - 1.0))
	
	add_theme_constant_override("separation", min(max_separation, separation_for_fill))
