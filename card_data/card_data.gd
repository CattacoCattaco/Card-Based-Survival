class_name CardData
extends Resource

@export var card_name: String = ""
@export var effect_text: String = ""

func _init(p_card_name: String = "", p_effect_text: String = "") -> void:
	card_name = p_card_name
	effect_text = p_effect_text
