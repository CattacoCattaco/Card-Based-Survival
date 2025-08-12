class_name CardData
extends Resource

@export var card_name: String = ""

func _init(p_card_name: String = "") -> void:
	card_name = p_card_name
