class_name Settings
extends Control

enum FromScreen {
	FIGHT,
	MAP,
}

enum ColorGroup {
	RED,
	ORANGE,
	YELLOW,
	GREEN,
	CYAN,
	BLUE,
	PURPLE,
}

enum ColorModifier {
	BRIGHT,
	DARK,
	DARKER,
	DARKEST,
	FADED,
	FADEDER,
	FADED_DARK,
	FADED_DARKER,
}

@export var play_zone: PlayZone
@export var hand: Hand

@export var reds: Array[Color]
@export var oranges: Array[Color]
@export var yellows: Array[Color]
@export var greens: Array[Color]
@export var cyans: Array[Color]
@export var blues: Array[Color]
@export var purples: Array[Color]

var from_screen: FromScreen
var map_scene: Map
var fight_scene: Fight

var color_options: Array[Array] = []

var player_color_coords := Vector2i(ColorModifier.BRIGHT, ColorGroup.GREEN)


func return_to_fight() -> void:
	get_tree().root.remove_child.call_deferred(self)
	get_tree().root.add_child.call_deferred(fight_scene)


func return_to_map() -> void:
	get_tree().root.remove_child.call_deferred(self)
	get_tree().root.add_child.call_deferred(map_scene)


func show_player_color() -> void:
	map_scene.map_bg.player.show_player_color()
	map_scene.play_zone.player_card.show_player_color()
	if fight_scene:
		fight_scene.play_zone.player_card.show_player_color()
	play_zone.player_card.show_player_color()


func get_player_color() -> Color:
	if not color_options:
		color_options = [
			reds,
			oranges,
			yellows,
			greens,
			cyans,
			blues,
			purples,
		]
	
	return color_options[player_color_coords.y][player_color_coords.x]
