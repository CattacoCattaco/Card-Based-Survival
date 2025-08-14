class_name Card
extends Control

@export var name_label: Label
@export var highlight_sprite: Sprite2D

@export var data: CardData

@export var hand: Hand

var highlighted: bool = false

var from_deck: bool = true


func _ready() -> void:
	_load_data(data)


func _load_data(new_data: CardData) -> void:
	data = new_data
	
	name_label.text = data.card_name


func unhighlight() -> void:
	highlight_sprite.hide()
	highlighted = false


func highlight() -> void:
	highlight_sprite.show()
	highlighted = true
