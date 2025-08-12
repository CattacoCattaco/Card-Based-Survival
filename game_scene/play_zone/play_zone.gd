class_name PlayZone
extends Control

@export var frame_sprite: Sprite2D
@export var label: Label

var drag_hapenning: bool = false
var drag_preview: ActionCard


func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)


func _on_mouse_entered() -> void:
	if drag_hapenning:
		drag_preview.highlight()
		highlight()


func _on_mouse_exited() -> void:
	if drag_hapenning:
		drag_preview.unhighlight()
		unhighlight()


func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return data is ActionCard


func _drop_data(at_position: Vector2, data: Variant) -> void:
	data.play()


func highlight() -> void:
	frame_sprite.texture = preload("res://game_scene/play_zone/play_region_frame_on.png")
	label.label_settings.font_color = Color(1, 0.737, 0)


func unhighlight() -> void:
	frame_sprite.texture = preload("res://game_scene/play_zone/play_region_frame_off.png")
	label.label_settings.font_color = Color(0, 0, 0)
