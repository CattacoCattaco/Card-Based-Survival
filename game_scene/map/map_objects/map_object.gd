class_name MapObject
extends Sprite2D

const PINE := Vector2i(0, 0)
const OAK := Vector2i(32, 0)
const ROCK := Vector2i(64, 0)
const GOLD := Vector2i(96, 0)
const IRON := Vector2i(0, 32)
const PLAYER := Vector2i(32, 32)
const BAG := Vector2i(64, 32)
const BEAR := Vector2i(96, 32)

const PINE_DATA: CharacterData = preload("res://card_data/character_data/objects/pine.tres")
const OAK_DATA: CharacterData = preload("res://card_data/character_data/objects/oak.tres")
const ROCK_DATA: CharacterData = preload("res://card_data/character_data/objects/stone.tres")
const GOLD_DATA: CharacterData = preload(
		"res://card_data/character_data/objects/gold_ore.tres")
const IRON_DATA: CharacterData = preload(
		"res://card_data/character_data/objects/iron_ore.tres")
const BEAR_DATA: CharacterData = preload(
		"res://card_data/character_data/enemy_characters/bear.tres")

var map_BG: MapBG

var pos: Vector2i


func show_player_color() -> void:
	set_art_replace_color(map_BG.map_control.settings.get_player_color())


func set_art_replace_color(replace_color: Color) -> void:
	var shader_material: ShaderMaterial = material
	shader_material.set_shader_parameter("new_color", replace_color)


func set_sprite(texture_pos: Vector2i) -> void:
	texture.region.position = texture_pos as Vector2


func do_event() -> void:
	match texture.region.position as Vector2i:
		PINE:
			map_BG.map_control.load_fight_scene([PINE_DATA], self)
		OAK:
			map_BG.map_control.load_fight_scene([OAK_DATA], self)
		ROCK:
			map_BG.map_control.load_fight_scene([ROCK_DATA], self)
		GOLD:
			map_BG.map_control.load_fight_scene([GOLD_DATA], self)
		IRON:
			map_BG.map_control.load_fight_scene([IRON_DATA], self)
		BEAR:
			map_BG.map_control.load_fight_scene([BEAR_DATA], self)
