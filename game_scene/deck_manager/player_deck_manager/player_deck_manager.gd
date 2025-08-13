class_name PlayerDeckManager
extends DeckManager

enum Mode {
	MAP,
	FIGHT,
}

@export var player_card: CharacterCard
@export var mode: Mode

var unused_cards: Array[ActionData] = []
var used_cards: Array[ActionData] = []


func _ready() -> void:
	match mode:
		Mode.MAP:
			unused_cards = player_card.movement_deck.duplicate()
		Mode.FIGHT:
			unused_cards = player_card.fight_deck.duplicate()


func _get_next_card() -> CardData:
	if not unused_cards:
		unused_cards = used_cards
		used_cards = []
	
	var chosen_card: ActionData = unused_cards.pick_random()
	unused_cards.erase(chosen_card)
	
	return chosen_card
