class_name MapObject
extends Sprite2D

const PINE := Vector2i(0, 0)
const OAK := Vector2i(32, 0)
const ROCK := Vector2i(64, 0)
const GOLD := Vector2i(96, 0)
const IRON := Vector2i(0, 32)
const PLAYER := Vector2i(32, 32)

var pos: Vector2i


func set_sprite(pos: Vector2i) -> void:
	texture.region.position = pos as Vector2
