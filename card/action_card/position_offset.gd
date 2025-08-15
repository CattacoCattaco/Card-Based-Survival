class_name ActionCardPositionOffset
extends Control

@export var action_card: ActionCard


func _get_drag_data(at_position: Vector2) -> Variant:
	var preview: ActionCard = load("res://card/action_card/action_card.tscn").instantiate()
	preview._load_data(action_card.data)
	preview.position_offset_control.position = -(at_position)
	preview.z_index = 11
	preview.set_art_replace_color(action_card.get_art_replace_color())
	
	set_drag_preview(preview)
	action_card.play_zone.drag_preview = preview
	
	action_card.hide()
	action_card.is_dragging = true
	
	action_card.play_zone.drag_hapenning = true
	
	return action_card
