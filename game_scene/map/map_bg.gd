class_name MapBG
extends TileMapLayer

const MAP_OBJECT_SCENE: PackedScene = preload("res://game_scene/map/map_objects/map_object.tscn")
const CENTER := Vector2i(256, 96)
const BOTTOM_RIGHT := Vector2i(512, 192)

@export var map_control: Control
@export var objects: Dictionary[Vector2i, Vector2i] = {}

var player: MapObject
var visible_objects: Dictionary[Vector2i, MapObject] = {}


func _ready() -> void:
	player = MAP_OBJECT_SCENE.instantiate()
	add_child(player)
	player.position = CENTER
	player.pos = Vector2i(0, 0)
	player.set_sprite(MapObject.PLAYER)
	
	display()


func display() -> void:
	for visible_object: MapObject in visible_objects.values():
		visible_object.queue_free()
	
	visible_objects = {}
	
	for pos in objects:
		var adjusted_pos: Vector2i = (pos - player.pos) * 32 + CENTER
		
		var object: MapObject = MAP_OBJECT_SCENE.instantiate()
		add_child(object)
		visible_objects[pos] = object
		
		object.position = adjusted_pos
		object.pos = pos
		object.set_sprite(objects[pos])


func move_up() -> void:
	if player.pos + Vector2i(0, -1) in visible_objects:
		visible_objects[player.pos + Vector2i(0, -1)].do_event(self)
		return
	
	player.pos.y -= 1
	
	for pos: Vector2i in visible_objects.keys():
		var visible_object: MapObject = visible_objects[pos]
		
		if visible_object.position.y < BOTTOM_RIGHT.y:
			visible_object.position.y += 32
		else:
			visible_object.queue_free()
			visible_objects.erase(pos)
	
	for pos in objects:
		var adjusted_pos: Vector2i = (pos - player.pos) * 32 + CENTER
		
		if adjusted_pos.y == 0 and pos_visible(adjusted_pos):
			var object: MapObject = MAP_OBJECT_SCENE.instantiate()
			add_child(object)
			visible_objects[pos] = object
			
			object.position = adjusted_pos
			object.pos = pos
			object.set_sprite(objects[pos])


func move_left() -> void:
	if player.pos + Vector2i(-1, 0) in visible_objects:
		visible_objects[player.pos + Vector2i(-1, 0)].do_event(self)
		return
	
	player.pos.x -= 1
	
	for pos: Vector2i in visible_objects.keys():
		var visible_object: MapObject = visible_objects[pos]
		
		if visible_object.position.x < BOTTOM_RIGHT.x:
			visible_object.position.x += 32
		else:
			visible_object.queue_free()
			visible_objects.erase(pos)
	
	for pos in objects:
		var adjusted_pos: Vector2i = (pos - player.pos) * 32 + CENTER
		
		if adjusted_pos.x == 0 and pos_visible(adjusted_pos):
			var object: MapObject = MAP_OBJECT_SCENE.instantiate()
			add_child(object)
			visible_objects[pos] = object
			
			object.position = adjusted_pos
			object.pos = pos
			object.set_sprite(objects[pos])


func move_down() -> void:
	if player.pos + Vector2i(0, 1) in visible_objects:
		visible_objects[player.pos + Vector2i(0, 1)].do_event(self)
		return
	
	player.pos.y += 1
	
	for pos: Vector2i in visible_objects.keys():
		var visible_object: MapObject = visible_objects[pos]
		
		if visible_object.position.y > 0:
			visible_object.position.y += 32
		else:
			visible_object.queue_free()
			visible_objects.erase(pos)
	
	for pos in objects:
		var adjusted_pos: Vector2i = (pos - player.pos) * 32 + CENTER
		
		if adjusted_pos.y == BOTTOM_RIGHT.y and pos_visible(adjusted_pos):
			var object: MapObject = MAP_OBJECT_SCENE.instantiate()
			add_child(object)
			visible_objects[pos] = object
			
			object.position = adjusted_pos
			object.pos = pos
			object.set_sprite(objects[pos])


func move_right() -> void:
	if player.pos + Vector2i(1, 0) in visible_objects:
		visible_objects[player.pos + Vector2i(1, 0)].do_event(self)
		return
	
	player.pos.x += 1
	
	for pos: Vector2i in visible_objects.keys():
		var visible_object: MapObject = visible_objects[pos]
		
		if visible_object.position.x > 0:
			visible_object.position.x += 32
		else:
			visible_object.queue_free()
			visible_objects.erase(pos)
	
	for pos in objects:
		var adjusted_pos: Vector2i = (pos - player.pos) * 32 + CENTER
		
		if adjusted_pos.x == BOTTOM_RIGHT.x and pos_visible(adjusted_pos):
			var object: MapObject = MAP_OBJECT_SCENE.instantiate()
			add_child(object)
			visible_objects[adjusted_pos] = object
			
			object.position = adjusted_pos
			object.pos = pos
			object.set_sprite(objects[pos])


func pos_visible(pos: Vector2i) -> bool:
	return pos.x >= 0 and pos.y >= 0 and pos.x <= BOTTOM_RIGHT.x and pos.y <= BOTTOM_RIGHT.y


func load_fight_scene(enemies: Array[CharacterData]) -> void:
	var fight_scene: Fight = preload("res://game_scene/fight/fight.tscn").instantiate()
	fight_scene.enemy_queue_manager.enemies = enemies
	get_tree().root.add_child(fight_scene)
	get_tree().root.remove_child(map_control)
