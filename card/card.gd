class_name Card
extends Control

@export var name_label: Label
@export var art_box: Sprite2D
@export var highlight_sprite: Sprite2D

@export var data: CardData

@export var hand: Hand

@export var play_zone: PlayZone

var highlighted: bool = false

var from_deck: bool = true


func _ready() -> void:
	_load_data(data)


func _load_data(new_data: CardData) -> void:
	data = new_data
	
	name_label.text = data.card_name
	art_box.texture = data.art


func unhighlight() -> void:
	highlight_sprite.hide()
	highlighted = false


func highlight() -> void:
	highlight_sprite.show()
	highlighted = true


func set_art_replace_color(replace_color: Color) -> void:
	var art_box_material: ShaderMaterial = art_box.material
	art_box_material.set_shader_parameter("new_color", replace_color)


func get_art_replace_color() -> Color:
	var art_box_material: ShaderMaterial = art_box.material
	return art_box_material.get_shader_parameter("new_color")
