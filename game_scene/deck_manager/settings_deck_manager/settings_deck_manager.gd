class_name SettingsDeckManager
extends DeckManager

enum Menu {
	MENU_SELECT,
	COLOR_GROUP_SELECT,
	COLOR_MODIFIER_SELECT,
}

@export var menu_cards: Array[ActionData] = []
@export var color_group_cards: Array[ActionData] = []
@export var color_modifier_cards: Array[ActionData] = []

@export var return_to_map_card: ActionData
@export var return_to_fight_card: ActionData

var menu: Menu = Menu.COLOR_GROUP_SELECT


func get_relevant_cards() -> Array[ActionData]:
	match menu:
		Menu.MENU_SELECT:
			return menu_cards
		Menu.COLOR_GROUP_SELECT:
			return color_group_cards
		Menu.COLOR_MODIFIER_SELECT:
			return color_modifier_cards
	
	return []
