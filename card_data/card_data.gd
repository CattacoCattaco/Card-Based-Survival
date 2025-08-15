class_name CardData
extends Resource

@export var card_name: String = ""
@export var art := Texture2D.new()

func _init(p_card_name: String = "", p_art := Texture2D.new()) -> void:
	card_name = p_card_name
	art = p_art
