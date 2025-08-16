class_name PlayZone
extends Control

@warning_ignore("unused_signal")
signal action_played()

@export var frame_sprite: Sprite2D
@export var label: Label

@export var player_card: CharacterCard
@export var map_BG: MapBG
@export var enemy_holder: Hand
@export var fight: Fight
@export var settings: Settings

var is_player_turn: bool = true
var drag_hapenning: bool = false
var drag_preview: ActionCard


func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	
	if map_BG:
		settings = map_BG.map_control.settings
	elif fight:
		pass


func _on_mouse_entered() -> void:
	if drag_hapenning:
		drag_preview.highlight()
		highlight()


func _on_mouse_exited() -> void:
	if drag_hapenning:
		drag_preview.unhighlight()
		unhighlight()


func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	return data is ActionCard


func _drop_data(_at_position: Vector2, data: Variant) -> void:
	await data.play()


func highlight() -> void:
	frame_sprite.texture = preload("res://game_scene/play_zone/play_region_frame_on.png")
	label.label_settings.font_color = Color(1, 0.675, 0)


func unhighlight() -> void:
	frame_sprite.texture = preload("res://game_scene/play_zone/play_region_frame_off.png")
	label.label_settings.font_color = Color(0, 0, 0)
