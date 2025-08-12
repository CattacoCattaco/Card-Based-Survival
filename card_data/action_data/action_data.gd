class_name ActionData
extends CardData

@export var effect_text: String = ""


func _init(p_card_name: String = "", p_effect_text: String = "") -> void:
	super(p_card_name)
	
	effect_text = p_effect_text
