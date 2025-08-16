class_name Hand
extends HBoxContainer

@warning_ignore("unused_signal")
signal target_found(target: Card)
signal enemies_loaded()

enum Mode {
	MAP_ACTIONS,
	FIGHT_ACTIONS,
	ENEMIES,
	SETTINGS_ACTIONS,
}

@export var card_scene: PackedScene
@export var max_separation: int = 5
@export var always_available_cards: Array[CardData]
@export var play_zone: PlayZone
@export var deck_manager: DeckManager
@export var mode: Mode

var cards: Array[Card] = []


func _ready() -> void:
	match mode:
		Mode.MAP_ACTIONS, Mode.FIGHT_ACTIONS:
			draw_hand()
		Mode.ENEMIES:
			draw_cards(len(deck_manager.enemies))
			enemies_loaded.emit()
		Mode.SETTINGS_ACTIONS:
			draw_settings_hand()


func discard_all() -> void:
	for card: Card in cards:
		if card.from_deck:
			deck_manager.used_cards.append(card.data)
		
		card.queue_free()
	
	cards = []


func draw_settings_hand() -> void:
	discard_all()
	
	play_zone.settings.show_player_color()
	
	var cards_to_draw: Array[CardData] = []
	for card: ActionData in deck_manager.get_relevant_cards():
		cards_to_draw.append(card)
	
	draw_specific_cards(cards_to_draw, false)
	
	match deck_manager.menu:
		SettingsDeckManager.Menu.COLOR_GROUP_SELECT:
			for card: ActionCard in cards:
				var color_group: int = card.data.effects[0].set_value
				card.set_art_replace_color(play_zone.settings.color_options[color_group][0])
		SettingsDeckManager.Menu.COLOR_MODIFIER_SELECT:
			for card: ActionCard in cards:
				var color_group: int = play_zone.settings.player_color_coords.y
				var color_modifier: int = card.data.effects[0].set_value
				var color: Color = play_zone.settings.color_options[color_group][color_modifier]
				card.set_art_replace_color(color)
	
	match play_zone.settings.from_screen:
		Settings.FromScreen.MAP:
			draw_specific_cards([deck_manager.return_to_map_card], false)
		Settings.FromScreen.FIGHT:
			draw_specific_cards([deck_manager.return_to_fight_card], false)


func draw_hand() -> void:
	discard_all()
	
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
	
	cards.append(card)
	add_child(card)
	
	card.hand = self
	card.play_zone = play_zone
	card._load_data(data)
	card.from_deck = from_deck
	card.set_art_replace_color(Color(0, 0, 0))


func recalc_card_separation() -> void:
	var combined_width: int = 125 * len(cards)
	@warning_ignore("narrowing_conversion")
	var unused_space: int = custom_minimum_size.x - combined_width
	var separation_for_fill: int = floori(unused_space / (len(cards) - 1.0))
	
	add_theme_constant_override("separation", min(max_separation, separation_for_fill))
