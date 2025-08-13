class_name MapBG
extends TileMapLayer

const MAP_OBJECT_SCENE: PackedScene = preload("res://game_scene/map/map_objects/map_object.tscn")
const CENTER := Vector2i(256, 96)
const BOTTOM_RIGHT := Vector2i(512, 192)

@export var objects: Dictionary[Vector2i, Vector2i] = {}

var player: MapObject
var visible_objects: Array[MapObject] = []


func _ready() -> void:
	player = MAP_OBJECT_SCENE.instantiate()
	add_child(player)
	player.position = CENTER
	player.pos = Vector2i(0, 0)
	player.set_sprite(MapObject.PLAYER)
	
	display()


func display() -> void:
	for visible_object in visible_objects:
		visible_object.queue_free()
	
	visible_objects = []
	
	for map_pos in objects:
		var adjusted_pos: Vector2i = (map_pos - player.pos) * 32 + CENTER
		
		var object: MapObject = MAP_OBJECT_SCENE.instantiate()
		add_child(object)
		visible_objects.append(object)
		
		object.position = adjusted_pos
		object.pos = map_pos
		object.set_sprite(objects[map_pos])


func move_up() -> void:
	player.pos.y -= 1
	
	var old_visible_objects: Array[MapObject] = visible_objects.duplicate()
	for visible_object in old_visible_objects:
		if visible_object.position.y < BOTTOM_RIGHT.y:
			visible_object.position.y += 32
		else:
			visible_objects.erase(visible_object)
			visible_object.queue_free()
	
	for map_pos in objects:
		var adjusted_pos: Vector2i = (map_pos - player.pos) * 32 + CENTER
		
		if adjusted_pos.y == 0 and pos_visible(adjusted_pos):
			var object: MapObject = MAP_OBJECT_SCENE.instantiate()
			add_child(object)
			visible_objects.append(object)
			
			object.position = adjusted_pos
			object.pos = map_pos
			object.set_sprite(objects[map_pos])


func move_left() -> void:
	player.pos.x -= 1
	
	var old_visible_objects: Array[MapObject] = visible_objects.duplicate()
	for visible_object in old_visible_objects:
		if visible_object.position.x < BOTTOM_RIGHT.x:
			visible_object.position.x += 32
		else:
			visible_objects.erase(visible_object)
			visible_object.queue_free()
	
	for map_pos in objects:
		var adjusted_pos: Vector2i = (map_pos - player.pos) * 32 + CENTER
		
		if adjusted_pos.x == 0 and pos_visible(adjusted_pos):
			var object: MapObject = MAP_OBJECT_SCENE.instantiate()
			add_child(object)
			visible_objects.append(object)
			
			object.position = adjusted_pos
			object.pos = map_pos
			object.set_sprite(objects[map_pos])


func move_down() -> void:
	player.pos.y += 1
	
	var old_visible_objects: Array[MapObject] = visible_objects.duplicate()
	for visible_object in old_visible_objects:
		if visible_object.position.y > 0:
			visible_object.position.y -= 32
		else:
			visible_objects.erase(visible_object)
			visible_object.queue_free()
	
	for map_pos in objects:
		var adjusted_pos: Vector2i = (map_pos - player.pos) * 32 + CENTER
		
		if adjusted_pos.y == BOTTOM_RIGHT.y and pos_visible(adjusted_pos):
			var object: MapObject = MAP_OBJECT_SCENE.instantiate()
			add_child(object)
			visible_objects.append(object)
			
			object.position = adjusted_pos
			object.pos = map_pos
			object.set_sprite(objects[map_pos])


func move_right() -> void:
	player.pos.x += 1
	
	var old_visible_objects: Array[MapObject] = visible_objects.duplicate()
	for visible_object in old_visible_objects:
		if visible_object.position.x > 0:
			visible_object.position.x -= 32
		else:
			visible_objects.erase(visible_object)
			visible_object.queue_free()
	
	for map_pos in objects:
		var adjusted_pos: Vector2i = (map_pos - player.pos) * 32 + CENTER
		
		if adjusted_pos.x == BOTTOM_RIGHT.x and pos_visible(adjusted_pos):
			var object: MapObject = MAP_OBJECT_SCENE.instantiate()
			add_child(object)
			visible_objects.append(object)
			
			object.position = adjusted_pos
			object.pos = map_pos
			object.set_sprite(objects[map_pos])


func pos_visible(pos: Vector2i) -> bool:
	return pos.x >= 0 and pos.y >= 0 and pos.x <= BOTTOM_RIGHT.x and pos.y <= BOTTOM_RIGHT.y
