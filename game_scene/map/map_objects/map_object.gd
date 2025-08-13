class_name MapObject
extends Sprite2D

const PINE := Vector2i(0, 0)
const OAK := Vector2i(32, 0)
const ROCK := Vector2i(64, 0)
const GOLD := Vector2i(96, 0)
const IRON := Vector2i(0, 32)
const PLAYER := Vector2i(32, 32)

const PINE_DATA: CharacterData = preload("res://card_data/character_data/enemy_objects/pine.tres")
const OAK_DATA: CharacterData = preload("res://card_data/character_data/enemy_objects/oak.tres")
const ROCK_DATA: CharacterData = preload("res://card_data/character_data/enemy_objects/stone.tres")
const GOLD_DATA: CharacterData = preload(
		"res://card_data/character_data/enemy_objects/gold_ore.tres")
const IRON_DATA: CharacterData = preload(
		"res://card_data/character_data/enemy_objects/iron_ore.tres")

var pos: Vector2i


func set_sprite(texture_pos: Vector2i) -> void:
	texture.region.position = texture_pos as Vector2


func do_event(map_BG: MapBG) -> void:
	match texture.region.position as Vector2i:
		PINE:
			map_BG.load_fight_scene([PINE_DATA])
		OAK:
			map_BG.load_fight_scene([OAK_DATA])
		ROCK:
			map_BG.load_fight_scene([ROCK_DATA])
		GOLD:
			map_BG.load_fight_scene([GOLD_DATA])
		IRON:
			map_BG.load_fight_scene([IRON_DATA])
