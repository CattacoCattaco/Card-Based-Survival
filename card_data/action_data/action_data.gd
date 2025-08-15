class_name ActionData
extends CardData

@export var effect_text: String = ""
@export var effects: Array[ActionEffect] = []
@export var replace: bool = true


func _init(p_card_name: String = "", p_art := Texture2D.new(), p_effect_text: String = "",
		p_effects: Array[ActionEffect] = [], p_replace: bool = true) -> void:
	super(p_card_name, p_art)
	
	effect_text = p_effect_text
	effects = p_effects
	replace = p_replace
