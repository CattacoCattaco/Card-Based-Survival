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

var movement_deck: Array[ActionData]


func show_player_color() -> void:
	set_art_replace_color(map_BG.map_control.settings.get_player_color())


func set_art_replace_color(replace_color: Color) -> void:
	var shader_material: ShaderMaterial = material
	shader_material.set_shader_parameter("new_color", replace_color)


func set_sprite(texture_pos: Vector2i) -> void:
	texture.region.position = texture_pos as Vector2


func move() -> void:
	var action: ActionData = movement_deck.pick_random()
	for effect: ActionEffect in action.effects:
		effect._resolve_as_enemy_object(self)


func move_in_dir(direction: Vector2i) -> void:
	if pos + direction == map_BG.player.pos:
		do_event()
		return
	
	map_BG.objects.erase(pos)
	if pos in map_BG.visible_objects:
		map_BG.visible_objects.erase(pos)
	
	pos += direction
	map_BG.objects[pos] = texture.region.position as Vector2i
	
	var new_adjusted_pos: Vector2i = map_BG.get_adjusted_pos(pos)
	if map_BG.pos_visible(new_adjusted_pos):
		map_BG.visible_objects[pos] = self
		position = new_adjusted_pos
	else:
		queue_free()


func do_event() -> void:
	var object_data: CharacterData = get_object_data()
	if object_data:
		map_BG.map_control.load_fight_scene([object_data], self)


func get_object_data() -> CharacterData:
	match texture.region.position as Vector2i:
		PINE:
			return PINE_DATA
		OAK:
			return OAK_DATA
		ROCK:
			return ROCK_DATA
		GOLD:
			return GOLD_DATA
		IRON:
			return IRON_DATA
		BEAR:
			return BEAR_DATA
	
	return null
