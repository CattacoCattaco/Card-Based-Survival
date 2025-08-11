class_name Card
extends Control

@export var name_label: Label
@export var effect_label: Label

@export var data: CardData


func _load_data(new_data: CardData):
	data = new_data
	
	name_label.text = data.card_name
	effect_label.text = data.effect_text
