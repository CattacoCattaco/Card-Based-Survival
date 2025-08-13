class_name ActionData
extends CardData

@export var effect_text: String = ""
@export var effects: Array[ActionEffect] = []


func _init(p_card_name: String = "", p_effect_text: String = "",
		p_effects: Array[ActionEffect] = []) -> void:
	super(p_card_name)
	
	effect_text = p_effect_text
	effects = p_effects
